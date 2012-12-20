class PeopleController < ApplicationController
  respond_to :html, :json, :js

  # GET /people
  # GET /people.xml
  def index
    # Make sure parameter exists and is an integer
    if params[:per_page] =~ /^\d+$/
      @per_page = params[:per_page]
    else
      @per_page = 10
    end
    @people = Person.paginate(page: params[:page], per_page: @per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render(xml: @people) }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    if params[:per_page] =~ /^\d+$/
      @per_page = params[:per_page]
    else
      @per_page = 10
    end
    @person = Person.find(params[:id])
    # Previous query
    #@my_etds = Etd.find(@person.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:etd_id))
    # New query to take advantage of pagination
    @my_etds = Etd.paginate(page: params[:page], per_page: @per_page, include: [:people_roles], 
                            conditions: {"people_roles.person_id" => params[:id], "people_roles.role_id" => Role.where(group: 'Creators')})
    @committee_etds = Etd.find(@person.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:etd_id))
    @reviewable_etds = Etd.where(status: "Submitted")

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render(xml: @person) }
    end
  end

  # GET /people/new_legacy
  def new
    @person = LegacyPerson.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @person) }
    end
  end

  # GET /people/edit_legacy/1
  def edit
    @person = Person.find(params[:id])
    respond_to do |format|
      if @person.valid?
        format.html { redirect_to(edit_person_registration_path(@person)) }
      else
        format.html # edit.html.erb
        format.xml  { render(xml: @person) }
      end
    end
  end

  # POST /people/new_legacy
  def create
    @person = LegacyPerson.new(params[:legacy_person])
    respond_to do |format|
      if @person.save
        Provenance.create(person: current_person, action: "created", model: @person)
        format.html { redirect_to(person_path(@person), notice: "#{@person.name} was successfully created.") }
      else
        format.html { render(action: "new") }
        format.json { render(json: @person.errors, status: :unprocessable_entity) }
      end
    end
  end

  # POST /people/edit_legacy
  def update
    @person = LegacyPerson.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:legacy_person])
        Provenance.create(person: current_person, action: "updated", model: @person)

        format.html { redirect_to(person_path(@person), notice: "#{@person.name} was successfully updated.") }
        format.json { head :ok }
      else
        format.html { render(action: "edit") }
        format.json { render(json: @person.errors, status: :unprocessable_entity) }
      end
    end
  end

  # POST /people/destroy_legacy
  def destroy
    @person = Person.find(params[:id])

    if @person.valid?
      redirect_to(people_path, notice: "That's a bad link. Please report this.")
    else
      Provenance.create(person: current_person, action: "destroyed", model: @person)
      @person.destroy

      respond_to do |format|
        format.html { redirect_to(people_path) }
        format.xml  { head :ok }
      end
    end
  end
end
