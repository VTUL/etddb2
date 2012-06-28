class EtdsController < ApplicationController
  skip_before_filter :authenticate_person!, only: [:show, :index]

  # GET /etds
  # GET /etds.xml
  def index
    # This is a bit of black magic.
    @etds = Etd.find(:all, include: [:people, :people_roles], order: 'people.last_name', conditions: ["people_roles.role_id = ?", Role.where(group: "Creators").pluck(:id)])

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
    @collabs = Person.find(@etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @etd) }
    end
  end

  # GET /etds/new
  # GET /etds/new.xml
  def new
    respond_to do |format|
      # BUG: This should be implemented as a before_filter.
      if person_signed_in?
        @etd = Etd.new
        format.html # new.html.erb
        format.xml  { render(xml: @etd) }
      else
        format.html { redirect_to(login_path, notice: "You must login create an ETD.") }
      end
    end
  end

  # GET /etds/1/edit
  def edit
    respond_to do |format|
      @etd = Etd.find(params[:id])
      # BUG: Again, this should be implemented in a before_filter
      if person_signed_in?
        # BUG: This works, but is only a hack, we should use Cancan.
        if current_person.etds.include?(@etd)
          format.html { render(action: "edit") }
        else
          format.html { redirect_to(etds_path, notice: "You cannot edit that ETD.") }
        end
      else
        format.html { redirect_to(login_path, notice: "You must sign in to edit ETDs.") }
      end
    end
  end

  # POST /etds
  # POST /etds.xml
  def create
    @etd = Etd.new(params[:etd])

    #Add implied params.
    @etd.cdate = Time.now()
    @etd.status = "Created"
    @etd.urn = Time.now().strftime("etd-%Y%m%d-%H%M%S%2L")
    @etd.url = "http://scholar.lib.vt.edu/theses/submitted/#{@etd.urn}/"

    # Don't add a blank second department.
    d = [params[:etd][:department_ids][:id_1]]
    if params[:etd][:department_ids][:id_2] != "" then
      d << params[:etd][:department_ids][:id_2]
    end
    @etd.department_ids = d

    # Make the current_person the creator, or preferably, author.
    pr = PeopleRole.new
    pr.person_id = current_person.id
    # TODO: Is there a better way to do give the creator's role?
    pr.role_id = !Role.where(name: 'Author').nil? ? Role.where(name: "Author").first.id : Role.where(group: 'Creators').first.id
    @etd.people_roles << pr

    respond_to do |format|
      if @etd.save
        Provenance.create(person: current_person, action: "created", model: @etd)
        EtddbMailer.confirm_create(@etd, current_person).deliver

        format.html { redirect_to(next_new_etd_path(@etd), notice: 'Etd was successfully created.') }
        format.xml  { render(xml: @etd, status: :created, location: @etd) }
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
    
    # Add a provenance
    prov = Provenance.new
    prov.person = current_person
    prov.action = "updated"
    @etd.provenances << prov

    respond_to do |format|
      if @etd.update_attributes(params[:etd])
        # Change the availability of all the ETD's contents, if the availability isn't mixed.
        # TODO: Is the where clause necessary? Would this be faster just updating all the contents?
        if @etd.availability_id != Availability.where(name: "Mixed").first.id
          contents = @etd.contents.where("availability_id != ?", @etd.availability_id)
          for content in contents do
            content.availability_id = @etd.availability_id
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

    # Add a provenance
    prov = Provenance.new
    prov.person = current_person
    prov.action = "destroyed"
    @etd.provenances << prov

    respond_to do |format|
      # BUG: Put in a before_filter.
      if person_signed_in?
        # BUG: Use Cancan for this.
        if current_person.etds.include?(@etd)
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
      else
        format.html { redirect_to(etds_path, notice: "You must log in to delete your ETDs.") }
      end
    end
  end

  # GET /etds/next_new/1
  def next_new
    # Assuming someone is signed in, and authorized, as this should only be accessable from /etd/new
    @etd = Etd.find(params[:id])
    @collabs = Person.find(@etd.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:person_id))

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

  # POST /etd/submit/1
  def submit
    @etd = Etd.find(params[:id])
    @etd.status = "Submitted"
    @etd.sdate = Time.now()
    @etd.save()
    
    # Add a provenance
    prov = Provenance.new
    prov.person = current_person
    prov.action = "submitted"
    @etd.provenances << prov

    @author = Person.find(@etd.people_roles.where(role_id: Role.where(group: 'Creators')).first.person_id)
    EtddbMailer.confirm_submit_author(@etd, @author).deliver
    EtddbMailer.confirm_submit_school(@etd, @author).deliver
    EtddbMailer.confirm_submit_committee(@etd, @author).deliver

    respond_to do |format|
      format.html #submit.html.erb
    end
  end

  # POST /etd/vote/1
  def vote
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if person_signed_in?
        if @etd.status == "Submitted"
          pr = @etd.people_roles.where(person_id: current_person.id).first
          if !pr.nil? && Role.where(group: 'Collaborators').pluck(:id).include?(pr.role_id)
            if params[:vote] == 'true'
              pr.vote = true
            else
              pr.vote = false
            end
            pr.save()

            # Add a provenance
            prov = Provenance.new
            prov.person = current_person
            prov.action = "voted on"
            @etd.provenances << prov

            # Check if the entire Committee has approved the ETD.
            @nonapproved = @etd.people_roles.where(role_id: Role.where(group: 'Collaborators'), vote: [false, nil]).count
            if @nonapproved == 0
              EtddbMailer.committee_approved(@etd).deliver
            end

            format.html #vote.html.erb
          else
            # Error. You are either not part of this ETD, or at least not on it's committee.
            format.html { redirect_to(person_path(current_person), notice: "You cannot vote on that ETD.") }
          end
        else
          # Error. ETD not submitted. You are either too early, or too late.
          format.html { redirect_to(person_path(current_person), notice: "That ETD is not ready to be voted on.") }
        end
      else
        # Error. Must be signed in. This should not be possible normally.
        format.html { redirect_to(login_path, notice: "You must log in to vote on an ETD.") }
      end
    end
  end
end
