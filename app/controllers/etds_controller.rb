class EtdsController < ApplicationController
  skip_before_filter :authenticate_person!, only: [:show, :index]

  # GET /etds
  # GET /etds.xml
  def index
    @creator_roles = Role.where(group: 'Creators').pluck(:id)
    @per_page = (params[:per_page] =~ /^\d+$/) ? params[:per_page] : 10

    # This is a bit of black magic.
    @etds = []
    case params[:orderby]
    when "department"
      # Previous query
      #@etds = Etd.find(:all, include: :departments, order: 'departments.name')
      # Updated query for pagination
      @etds = Etd.paginate(page: params[:page], per_page: @per_page, include: :departments, order: 'departments.name')
    when "title"
      # Previous query
      #@etds = Etd.find(:all, order: 'title')
      # Updated query for pagination
      @etds = Etd.paginate(page: params[:page], per_page: @per_page,  order: 'title')
    else
      # Previous query
      #@etds = Etd.find(:all, include: [:people, :people_roles], order: 'people.last_name', conditions: ["people_roles.role_id = ?", Role.where(group: "Creators").pluck(:id)])
      # Updated query for pagination
      @etds = Etd.search(params[:keywords]).paginate(page: params[:page], :per_page => @per_page, include: :people, order: 'people.last_name')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render(xml: @etds) }
    end
  end

  # GET /etds/1
  # GET /etds/1.xml
  def show
    @etd = Etd.find(params[:id])
    @creators = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
    @collabs = @etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).sort_by { |pr| [pr.role.name] }

    # TODO: Add access rights management code, or implement Cancan.

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @etd) }
    end
  end

  # GET /available/etd-00000000-00000000
  def old_show
    @etd = Etd.where(urn: params[:urn]).first

    if !@etd.nil?
      # Redirect to the ETD's new path (Let it take care of access rights.)
      redirect_to(etd_path(@etd), status: :moved_permanently)
    else
      # TODO: Make this less generic, or better yet, a 404.
      render #old_show.html.erb
    end
  end

  # GET /etds/new
  # GET /etds/new.xml
  def new
    respond_to do |format|
      @etd = Etd.new
      format.html # new.html.erb
      format.xml  { render(xml: @etd) }
    end
  end

  # GET /etds/1/edit
  def edit
    respond_to do |format|
      @etd = Etd.find(params[:id])
      # BUG: This works, but is only a hack, we should use Cancan.
      if current_person.etds.include?(@etd) || !(current_person.roles & Role.where(group: ['Graduate School', 'Administration'])).empty?
        format.html { render(action: "edit") }
      else
        format.html { redirect_to(etds_path, notice: "You cannot edit that ETD.") }
      end
    end
  end

  # POST /etds
  # POST /etds.xml
  def create
    @etd = Etd.new(params[:etd])

    #Add implied params.
    @etd.status = "Created"
    @etd.urn = Time.now().strftime("etd-%Y%m%d-%H%M%S%2L")
    @etd.url = "http://scholar.lib.vt.edu/theses/submitted/#{@etd.urn}/"

    # Don't add a blank second department.
    d = [params[:etd][:department_ids][:id_1]]
    if params[:etd][:department_ids][:id_2] != "" then
      d << params[:etd][:department_ids][:id_2]
    end
    @etd.department_ids = d

    # Add the default reason.
    @etd.reason = @etd.availability.reason

    respond_to do |format|
      if @etd.save
        Provenance.create(person: current_person, action: "created", model: @etd)

        if (current_person.roles & Role.where(group: "Administration")).empty?
          # Defer creating the author.
          # Don't email, or warn about the availability
          format.html { redirect_to(add_author_to_etd_path(@etd), notice: 'Etd was successfully created.') }
          format.xml  { render(xml: @etd, status: :created, location: @etd) }
        else
          # Make the current_person the creator, or preferably, author.
          pr = PeopleRole.new(person_id: current_person.id, etd_id: @etd.id)
          pr.role = !Role.where(name: 'Author').nil? ? Role.where(name: "Author").first.id : Role.where(group: 'Creators').first
          pr.save

          # Email ALL the people!
          EtddbMailer.created_authors(@etd).deliver

          # Warn the Author and Committee Chair if the release reason says so.
          if @etd.reason && @etd.reason.warn_before_approval
            # TODO: Email Author and Committee Chair
          end

          format.html { redirect_to(next_new_etd_path(@etd), notice: 'Etd was successfully created.') }
          format.xml  { render(xml: @etd, status: :created, location: @etd) }
        end
      else
        format.html { render(action: "new", notice: 'You have errors.') }
        format.xml  { render(xml: @etd.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /etds/1
  # PUT /etds/1.xml
  def update
    @etd = Etd.find(params[:id])

    # Don't add a blank second department.
    d = [params[:etd][:department_ids][:id_1]]
    if params[:etd][:department_ids][:id_2] != "" then
      d << params[:etd][:department_ids][:id_2]
    end
    params[:etd][:department_ids] = d

    # Update the reason if the availability changes.
    if @etd.availability_id != Integer(params[:etd][:availability_id])
      @etd.reason = Availability.find(params[:etd][:availability_id]).reason
      @etd.save
    end

    respond_to do |format|
      if @etd.update_attributes(params[:etd])
        Provenance.create(person: current_person, action: "updated", model: @etd)

        # Change the availability of all the ETD's contents, if the availability isn't mixed.
        if !@etd.availability.etd_only
          for content in @etd.contents do
            content.availability= @etd.availability
            content.reason = @etd.reason
            content.save
          end
        end

        format.html { redirect_to(@etd, notice: 'Etd was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "edit") }
        format.xml  { render(xml: @etd.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /etds/1
  # DELETE /etds/1.xml
  def destroy
    @etd = Etd.find(params[:id])

    respond_to do |format|
      # BUG: Use Cancan for this.
      if current_person.etds.include?(@etd) || !(current_person.roles & Role.where(group: ['Graduate School', 'Administration'])).empty?
        Provenance.create(person: current_person, action: "deleted", model: @etd)

        for pr in @etd.people_roles do
          pr.destroy
        end
        for content in @etd.contents do
          content.destroy
        end

        @etd.destroy
        format.html { redirect_to(action: 'index', notice: "ETD Deleted.") }
        format.xml  { head :ok }
      else
        format.html { redirect_to(etds_path, notice: "You cannot delete that ETD.") }
      end
    end
  end

  # GET /etds/add_author/1
  def add_author
    @etd = Etd.find(params[:id])

    respond_to do |format|
      format.html # add_author.html.erb
    end
  end

  # POST /etds/add_author
  def save_author
    @etd = Etd.find(params[:id])
    @role = !Role.where(name: 'Author').nil? ? Role.where(name: "Author").first : Role.where(group: 'Creators').first
    @pr = PeopleRole.new(person_id: params[:person_id], role_id: @role.id, etd_id: @etd.id)

    if @pr.save
      Provenance.create(person: current_person, action: "created", model: @pr)
      redirect_to(next_new_etd_path(@etd))
    else
      format.html { render(action: "add_author", notice: 'You have errors.') }
      format.xml  { render(xml: @etd.errors, status: :unprocessable_entity) }
    end
  end

  # GET /etds/next_new/1
  def next_new
    # Assuming someone is signed in, and authorized, as this should only be accessable from /etd/new
    @etd = Etd.find(params[:id])
    @collabs = @etd.people_roles.where(role_id: Role.where(group: "Collaborators")).sort_by { |pr| [pr.role.name] }

    respond_to do |format|
      format.html # new_next.html.erb
    end
  end

  # PUT /etds/next_new/1
  # (This is used from next_new, and add_contents)
  def save_contents
    @etd = Etd.find(params[:id])

    # Whitelist params[:origin]
    origins = ["/etds/add_contents/", "/etds/next_new/"]
    if !origins.include?(params[:origin])
      params[:origin] = "/etds/add_contents/"
    end

    if @etd.update_attributes(params[:etd])
      Provenance.create(person: current_person, action: "added contents to", model: @etd)
      redirect_to(params[:origin] + @etd.id.to_s, notice: "Successfully updated article.")
    else
      redirect_to(params[:origin] + @etd.id.to_s)
    end    
  end

  # GET /etds/add_contents/1
  def add_contents
    @etd = Etd.find(params[:id])

    respond_to do |format|
      format.html # add_contents.html.erb
    end
  end

  # GET /etds/add_reason/1
  def pick_reason
    @etd = Etd.find(params[:id])
    @reasons = [@etd.reason] 
    if @etd.availability.allows_reasons
      @reasons += Reason.where("name NOT IN (?)", Availability.pluck(:name))
    end

    respond_to do |format|
      format.html #pick_reason.html.erb
    end
  end

  # PUT /etds/add_reason/1
  def add_reason
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.update_attributes(params[:etd])
        Provenance.create(person: current_person, action: "changed the release reason for", model: @etd)

        format.html { redirect_to(@etd, notice: 'Etd was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "pick_reason") }
        format.xml  { render(xml: @etd.errors, status: :unprocessable_entity) }
      end
    end
  end

  # POST /etd/submit/1
  def submit
    respond_to do |format|
      # ETD must have atleast one committee member, and one piece of content.
      if @etd.contents.length > 0 && @etd.people_roles.where(role_id: Role.where(group: 'Collaborators').pluck(:id)).pluck(:person_id).uniq.count > 0
        @etd = Etd.find(params[:id])
        @etd.status = "Submitted"
        @etd.submission_date = Time.now()
        @etd.save()

        #Create an archive of the ETD for easy downloading.
        Resque.enqueue(Archive, @etd.id)

        Provenance.create(person: current_person, action: "submitted", model: @etd)

        EtddbMailer.submitted_authors(@etd).deliver
        EtddbMailer.submitted_school(@etd).deliver
        EtddbMailer.submitted_committee(@etd).deliver

        format.html #submit.html.erb
      else
        # Redirect to etd, prompt to add content, committee.
        redirect_to(etd_path(@etd), notice: 'Please add a committee member and some content before submitting.')
      end
    end
  end

  # POST /etd/vote/1
  def vote
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.status == "Submitted"
        pr = @etd.people_roles.where(person_id: current_person.id).first
        if !pr.nil? && Role.where(group: 'Collaborators').pluck(:id).include?(pr.role_id)
          if params[:vote] == 'true'
            pr.vote = true
          else
            pr.vote = false
          end
          pr.save()

          Provenance.create(person: current_person, action: "voted on", model: @etd)

          # Check if the entire Committee has approved the ETD.
          @nonapproved = @etd.people_roles.where(role_id: Role.where(group: 'Collaborators'), vote: [false, nil]).count
          if @nonapproved == 0
            EtddbMailer.approved_school(@etd).deliver
          end

          format.html #vote.html.erb
        else
          # Error. You are not part of this ETD's committee.
          format.html { redirect_to(person_path(current_person), notice: "You cannot vote on that ETD.") }
        end
      else
        # Error. ETD not submitted. You are either too early, or too late.
        format.html { redirect_to(person_path(current_person), notice: "That ETD is not ready to be voted on.") }
      end
    end
  end

  # POST /etd/unsubmit/1
  def unsubmit
    @etd = Etd.find(params[:id])
    
    respond_to do |format|
      if @etd.status == "Submitted"
        if !current_person.roles.where(group: 'Graduate School').empty?
          @etd.status = "Created"
          @etd.save
          
          Provenance.create(person: current_person, action: "unsubmitted", model: @etd)
  
          format.html { redirect_to(etd_path(@etd), notice: "Successfully unsubmitted this ETD.") }
        else
          format.html { redirect_to(person_path(current_person), notice: "You cannot unsubmit ETDs.") }
        end
      else
        format.html { redirect_to(person_path(current_person), notice: "You cannot unsubmit an ETD that hasn't been submitted.") }
      end
    end
  end

  # GET /etd/reviewboard/1
  def reviewboard
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.status == 'Submitted'
        # TODO: Limit access.
        @collabs = @etd.people_roles.where(role_id: Role.where(group: "Collaborators")).sort_by { |pr| [pr.role.name] }
        format.html
      else
        format.html { redirect_to(etd_path(@etd), notice: "This ETD doesn't currently have a review board.") }
      end
    end
  end

  # POST /etd/approve/1
  def approve
    @etd = Etd.find(params[:id])
    @etd.approval_date = Time.now()
    @etd.release_date = @etd.reason.months_to_release.months.from_now if @etd.reason.months_to_release >= 0
    @etd.status = (@etd.months.reason.months_to_release == 0 && !@etd.availability.etd_only?) ? 'Released' : 'Approved'
    @etd.save()

    Provenance.create(person: current_person, action: 'approved', model: @etd)
    Provenance.create(person: current_person, action: 'released (by approving)', model: @etd) if @etd.reason.months_to_release == 0 && !@etd.availability.etd_only?

    EtddbMailer.approved_authors(@etd).deliver
    EtddbMailer.approved_committee(@etd).deliver
    # If the availability is not etd only, and there is no time until release, the ETD is available.
    if @etd.document_type == DocumentType.where(name: 'Dissertation').first && !@etd.availability.etd_only? && @etd.reason.months_to_release == 0
      EtddbMailer.approved_proquest(@etd).deliver
    end

    # Queue up releases and warnings.
    # If months_to_release is 0, it is now considered released. If it is less than 0, it will never be released.
    Resque.enqueue_at(@etd.reason.months_to_release.months.from_now, Release, @etd.class.name, @etd.id) if @etd.reason.months_to_release > 0
    Resque.enqueue_at(@etd.reason.months_to_warning.months.from_now, Warning, @etd.class.name, @etd.id) if (@etd.reason.months_to_warning > 0) || (@etd.reason.months_to_warning == 0 && !@etd.reason.warn_before_approval?)
    if @etd.availability.etd_only?
      for content in @etd.contents do
        Resque.enqueue_at(content.reason.months_to_release.months.from_now, Release, content.class.name, content.id) if content.reason.months_to_release > 0
        Resque.enqueue_at(content.reason.months_to_warning.months.from_now, Warning, content.class.name, content.id) if (content.reason.months_to_warning > 0) || (content.reason.months_to_warning == 0 && !content.reason.warn_before_approval?)
      end
    end

    respond_to do |format|
      format.html # approve.html.erb
    end
  end

  # POST /etd/delay_release/1
  def delay_release
    Resque.remove_delayed(params[:worker].constantize, params[:class_type], params[:class_id])
    Resque.enqueue_at(params[:months].to_i.months.from_now, params[:worker].constantize, params[:class_type], params[:class_id])
  end
end
