class EtdsController < ApplicationController
  skip_before_filter :authenticate_person!, only: [:old_show, :show, :index]

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
      @etds = Etd.where(status: ["Approved", "Released"]).paginate(page: params[:page], per_page: @per_page, include: :departments, order: 'departments.name')
    when "title"
      # Previous query
      #@etds = Etd.find(:all, order: 'title')
      # Updated query for pagination
      @etds = Etd.where(status: ["Approved", "Released"]).paginate(page: params[:page], per_page: @per_page, order: 'title')
    else
      # Previous query
      #@etds = Etd.find(:all, include: [:people, :people_roles], order: 'people.last_name', conditions: ["people_roles.role_id = ?", Role.where(group: "Creators").pluck(:id)])
      # Updated query for pagination
      @etds = Etd.search(params[:keywords]).where(status: ["Approved", "Released"]).paginate(page: params[:page], :per_page => @per_page, include: :people, order: 'people.last_name')
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

    respond_to do |format|
      # TODO: Should anyone associated with the ETD have unfettered access, or just the creators and collaborators?
      if Etd::ACCESS.matches?(request.ip, @etd.availability, nil, current_person) || @etd.people.include?(current_person)
        @creators = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
        @emails = @creators.where(show_email: true).pluck(:email).join(', ')
        @collabs = @etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).sort_by { |pr| [pr.role.name] }
        format.html # show.html.erb
        format.xml  { render(xml: @etd) }
      else
        # TODO: Perhaps log IPs that are hitting these pages?
        format.html { redirect_to(etds_path, notice: 'Access to that ETD is restricted.') }
      end
    end
  end

  # GET /available/etd-00000000-00000000
  def old_show
    @etd = Etd.where(urn: params[:urn]).first

    # No access constraint, as it is handled in the redirect.
    if !@etd.nil?
      redirect_to(etd_path(@etd), status: :moved_permanently)
    else
      # TODO: Should redirect to the advanced search page?
      redirect_to(etds_path, notice: "I can't find that ETD, but you can search for it here.")
    end
  end

  # GET /etds/new
  # GET /etds/new.xml
  def new
    respond_to do |format|
      @etd = Etd.new
      @is_admin = current_person.in_role_group?("Administration")
      @availabilities = @is_admin ? Availability.all : Availability.where(retired: false)
      @copyright = CopyrightStatement.where(retired: false).last
      @privacy = PrivacyStatement.where(retired: false).last

      format.html # new.html.erb
      format.xml  { render(xml: @etd) }
    end
  end

  # GET /etds/1/edit
  def edit
    respond_to do |format|
      @etd = Etd.find(params[:id])
      @is_admin = current_person.in_role_group?("Administration")

      if current_person.etds.include?(@etd) || @is_admin
        @availabilities = @is_admin ? Availability.all : Availability.where(retired: false)
        @copyright = CopyrightStatement.where(retired: false).last
        @privacy = PrivacyStatement.where(retired: false).last

        format.html #{ render(action: "edit") }
      else
        format.html { redirect_to(etds_path, notice: "You cannot edit that ETD.") }
      end
    end
  end

  # POST /etds
  # POST /etds.xml
  def create
    @etd = Etd.new(params[:etd].except(:department_ids))
    @is_admin = current_person.in_role_group?("Administration")
    @availabilities = @is_admin ? Availability.all : Availability.where(retired: false)
    @copyright = CopyrightStatement.where(retired: false).last
    @privacy = PrivacyStatement.where(retired: false).last

    #Add implied params.
    @etd.status = "Created"
    @etd.urn = Time.now().strftime("etd-%Y%m%d-%H%M%S%2L")
    @etd.url = "http://scholar.lib.vt.edu/theses/submitted/#{@etd.urn}/"
    @etd.bound = params[:etd][:bound] == '1' ? true : false

    # Don't add a blank second department.
    d = [params[:etd][:department_ids][:id_1]]
    d << params[:etd][:department_ids][:id_2] unless params[:etd][:department_ids][:id_2].empty?
    @etd.department_ids = d

    # Sanitize title and abstract
    @etd.title = Sanitize.clean(params[:etd][:title], Sanitize::Config::BASIC)
    @etd.abstract = Sanitize.clean(params[:etd][:abstract], Sanitize::Config::RELAXED)

    # Add the default reason.
    @etd.reason = @etd.availability.reason

    respond_to do |format|
      if @etd.save
        Provenance.create(person: current_person, action: "created", model: @etd)

        if @is_admin
          # Defer creating the author.
          # Don't email, or warn about the availability
          format.html { redirect_to(add_creator_to_etd_path(@etd)) }
          format.xml  { render(xml: @etd, status: :created, location: @etd) }
        else
          # Make the current_person the creator, or preferably, author.
          pr = PeopleRole.new(person_id: current_person.id, etd_id: @etd.id)
          pr.role = !Role.where(name: 'Author').empty? ? Role.where(name: "Author").first : Role.where(group: 'Creators').first
          pr.save

          EtddbMailer.created_authors(@etd).deliver

          format.html { redirect_to(add_collaborator_to_etd_path(@etd)) }
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
    @copyright = CopyrightStatement.where(retired: false).last
    @privacy = PrivacyStatement.where(retired: false).last

    # Don't add a blank second department.
    d = [params[:etd][:department_ids][:id_1]]
    d << params[:etd][:department_ids][:id_2] unless params[:etd][:department_ids][:id_2].empty?
    @etd.department_ids = d

    # Make sure bound is really boolean
    @etd.bound = params[:etd][:bound] == '1' ? true : false

    # Update the reason if the availability changes.
    if @etd.availability_id != Integer(params[:etd][:availability_id])
      @etd.reason = Availability.find(params[:etd][:availability_id]).reason
      @etd.save
    end

    # Sanitize title and abstract
    @etd.title = Sanitize.clean(params[:etd][:title], Sanitize::Config::BASIC)
    @etd.abstract = Sanitize.clean(params[:etd][:abstract], Sanitize::Config::RELAXED)

    respond_to do |format|
      if @etd.update_attributes(params[:etd].except(:department_ids, :title, :abstract))
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

  # POST /etds/1/destroy
  # POST /etds/1/destroy.xml
  def destroy
    @etd = Etd.find(params[:id])

    respond_to do |format|
      # BUG: Use Cancan for this.
      if (current_person.etds.include?(@etd) && @etd.status == "Created") || !(current_person.roles & Role.where(group: ['Graduate School', 'Administration'])).empty?
        Provenance.create(person: current_person, action: "deleted", model: @etd)

        for pr in @etd.people_roles do
          pr.destroy
        end
        for content in @etd.contents do
          content.destroy
        end

        @etd.destroy
        # TODO: Redirect somewhere better?
        format.html { redirect_to(etds_path, notice: "ETD Deleted.") }
        format.xml  { head :ok }
      else
        format.html { redirect_to(etds_path, notice: "You cannot delete that ETD.") }
      end
    end
  end

  # GET /etds/1/add_creator
  def add_creator
    @etd = Etd.find(params[:id])
    @candidates = []

    respond_to do |format|
      format.html # add_creator.html.erb
    end
  end

  # GET /etds/1/add_collaborator
  def add_collaborator
    @etd = Etd.find(params[:id])
    @candidates = []

    respond_to do |format|
      format.html # add_collaborator.html.erb
    end
  end

  # POST /etds/find/
  def find_person
    @etd = Etd.find(params[:id])
    @role_group = Role::GROUPS.include?(params[:role_group]) ? params[:role_group] : 'Collaborators'

    respond_to do |format|
      if params[:name].nil?
        format.html # find_person.html.erb
        @candidates = []
      else
        @name = params[:name].upcase
        @name = '#####' if @name.empty?
        @candidates = Person.where("UPPER(first_name) LIKE '%#{@name}%' OR UPPER(last_name) LIKE '%#{@name}%' OR UPPER(display_name) LIKE '%#{@name}%'").limit(10)
        format.js # find_person.js.erb
        format.html # find_person.html.erb
      end
    end
  end

  # POST /etds/find_person
  def save_person
    @etd = Etd.find(params[:id])
    PeopleRole.create(etd_id: params[:id], role_id: params[:role_id], person_id: params[:candidate_id])

    respond_to do |format|
      # TODO: redirect to adding content, if appropriate.
      format.html { redirect_to(etd_path(@etd)) }
    end
  end

  # GET /etds/1/add_contents
  def add_contents
    @etd = Etd.find(params[:id])

    respond_to do |format|
      format.html # add_contents.html.erb
    end
  end

  # GET /etds/1/contents
  def contents
    @etd = Etd.find(params[:id])
    @availabilities = Availability.where(retired: false, etd_only: false)
    @availabilities += Availability.where(retired: true, etd_only: false) if @etd.bound?
    @reasons = Reason.where("name NOT IN (?)", Availability.pluck(:name))

    respond_to do |format|
      format.html # content.html.erb
    end
  end

  # PUT /etds/1/add_contents
  # This is used from add_contents and contents.
  def save_contents
    @etd = Etd.find(params[:id])

    if params[:content].nil?
      @etd.update_attributes(params[:etd])
    else
      content = Content.new(content: params[:content], bound: params[:bound], availability_id: params[:availability_id], reason_id: params[:reason_id])
      @etd.contents << content
      @etd.update_attribute(:updated_at, Time.now())
    end
    #if @etd.update_attributes(params[:etd])
    #  Provenance.create(person: current_person, action: "added contents to", model: @etd)
      redirect_to(etd_contents_path(@etd), notice: "Successfully updated article.")
    #else
    #  redirect_to(add_contents_to_etd_path(@etd))
    #end
  end

  # GET /etds/1/add_reason
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

  # PUT /etds/1/add_reason
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

  # POST /etd/1/submit
  def submit
    respond_to do |format|
      @etd = Etd.find(params[:id])
      # ETD must have atleast one committee member, and one piece of content.
      if @etd.contents.length > 0 && @etd.people_roles.where(role_id: Role.where(group: 'Collaborators').pluck(:id)).pluck(:person_id).uniq.count > 0
        @etd.status = "Submitted"
        @etd.submission_date = Time.now()
        @etd.save()

        #Create an archive of the ETD for easy downloading.
        # TODO: uncomment for redis/resque
        #Resque.enqueue(Archive, @etd.id)

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

  # POST /etds/1/vote
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

  # POST /etds/1/unsubmit
  def unsubmit
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.status == "Submitted"
        if current_person.in_role_group?("Graduate School")
          @etd.status = "Created"
          @etd.save

          Provenance.create(person: current_person, action: "unsubmitted", model: @etd)

          EtddbMailer.unsubmitted_authors(@etd).deliver

          format.html { redirect_to(etd_path(@etd), notice: "Successfully unsubmitted this ETD.") }
        else
          format.html { redirect_to(person_path(current_person), notice: "You cannot unsubmit ETDs.") }
        end
      else
        format.html { redirect_to(person_path(current_person), notice: "You cannot unsubmit an ETD that hasn't been submitted.") }
      end
    end
  end

  # GET /etds/1/reviewboard
  def reviewboard
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.status == 'Submitted'
        # TODO: Limit access.
        @creators = Person.where(id: @etd.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:person_id)).order('last_name ASC')
        @collabs = @etd.people_roles.where(role_id: Role.where(group: "Collaborators")).sort_by { |pr| [pr.role.priority] }
        format.html
      else
        format.html { redirect_to(etd_path(@etd), notice: "This ETD doesn't currently have a review board.") }
      end
    end
  end

  # POST /etds/1/approve
  def approve
    @etd = Etd.find(params[:id])
    @etd.approval_date = Time.now()
    @etd.release_date = @etd.reason.months_to_release.months.from_now if @etd.reason.months_to_release >= 0
    @etd.status = (@etd.reason.months_to_release == 0 && !@etd.availability.etd_only?) ? 'Released' : 'Approved'
    @etd.save()

    Provenance.create(person: current_person, action: 'approved', model: @etd)
    Provenance.create(person: current_person, action: 'released (by approval)', model: @etd) if @etd.reason.months_to_release == 0 && !@etd.availability.etd_only?

    EtddbMailer.approved_authors(@etd).deliver
    EtddbMailer.approved_committee(@etd).deliver
    # If the availability is not etd only, and there is no time until release, the ETD is available.
    if @etd.document_type == DocumentType.where(name: 'Dissertation').first && !@etd.availability.etd_only? && @etd.reason.months_to_release == 0
      EtddbMailer.approved_proquest(@etd).deliver
    end

    # Queue up releases and warnings.
    # If months_to_release is 0, it is now considered released. If it is less than 0, it will never be released.
    # TODO: uncomment for redis/resque
    #Resque.enqueue_at(@etd.release_date.to_time, Release, @etd.class.name, @etd.id) if @etd.reason.months_to_release > 0
    #Resque.enqueue_at(@etd.reason.months_to_warning.months.from_now, Warning, @etd.class.name, @etd.id) if (@etd.reason.months_to_warning > 0) ||
    #  (@etd.reason.months_to_warning == 0 && !@etd.reason.warn_before_approval?)
    #if @etd.availability.etd_only?
    #  for content in @etd.contents do
    #    Resque.enqueue_at(content.reason.months_to_release.months.from_now, Release, content.class.name, content.id) if content.reason.months_to_release > 0
    #    Resque.enqueue_at(content.reason.months_to_warning.months.from_now, Warning, content.class.name, content.id) if (content.reason.months_to_warning > 0) ||
    #      (content.reason.months_to_warning == 0 && !content.reason.warn_before_approval?)
    #  end
    #end

    respond_to do |format|
      format.html # approve.html.erb
    end
  end

  # GET /etds/1/delay_release
  def delay_release
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.status == 'Approved'
        if !@etd.availability.etd_only?
          format.html # delay_release.html.erb
        else
          # TODO: Redirect somewhere else?
          format.html { redirect_to(etd_content_path(@etd), notice: "You must delay the release of this ETD's content individually.") }
        end
      else
        format.html { redirect_to(etd_path(@etd), notice: "This ETD it not available for release at this time.") }
      end
    end
  end

  # POST /etds/1/delay_release
  def process_delay_release
    @etd = Etd.find(params[:id])
    @etd.release_date = (@etd.release_date + params[:months].to_i.months)
    @etd.save
    Provenance.create(person: current_person, action: 'delayed the release of', model: @etd)

    # TODO: uncomment for redis/resque
    #Resque.remove_delayed(Release, 'Etd', params[:id].to_i)
    #Resque.enqueue_at(@etd.release_date.to_time, Release, 'Etd', params[:id].to_i)
    #if params[:rewarn] && params[:months].to_i >= 2
    #  Resque.remove_delayed(Warning, 'Etd', params[:id].to_i)
    #  Resque.enqueue_at((@etd.release_date.to_time - 1.month), Warning, 'Etd', params[:id].to_i)
    #end

    respond_to do |format|
      format.html { redirect_to(etd_path(@etd), notice: "Successfully delayed release.") }
    end
  end
end
