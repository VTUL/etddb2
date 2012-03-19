class PeopleController < ApplicationController
  respond_to :html, :json, :js

  # GET /people
  # GET /people.xml
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/new
  # GET /people/new.xml
  def new
    @person = Person.new
    @ability = Ability.new(@person)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @person }
    end
  end

  # GET /people/1/edit
  def edit
    #@session = Session.last
    #@ability = Ability.new(@)
    #@current_user = @session.user
    @person = Person.find(params[:id])
    @ability = Ability.new(@person)
  end

  # POST /people
  # POST /people.xml
  def create
    @person = Person.new(params[:person])

    #puts params.to_yaml
    #puts @person.to_yaml

    @person.display_name = @person.first_name + " " + @person.last_name

    respond_to do |format|
      if @person.save!
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /people/1
  # PUT /people/1.xml
  def update
    authorize! :assign_roles, @person if params[:person][:roles]

    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(params[:person])
        format.html { redirect_to(@person, :notice => 'Person was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @person = Person.find(params[:id])

    # Destroy ETDs this person has Authored.
    author = Role.where(:name => "Author").first()
    for pr in @person.people_roles do
      if pr.role_id == author.id
        etd = Etd.find(pr.etd_id)
        etd.destroy
      end
    end

    @person.destroy

    respond_to do |format|
      format.html { redirect_to(people_url) }
      format.xml  { head :ok }
    end
  end

  # POST /people/find/
  def find
    respond_to do |format|
      if params[:lname].nil?
        format.html { render(:action => "find") }
      else
        format.js { render :parital => "people/find" }
        format.html { render(:action => "new_committee_member") }
      end
    end
  end

  # POST /people/new_committee_member
  def new_committee_member
    respond_to do |format|
      format.html {render :action => "new_committee_member"}
    end
  end

  # POST /people/add_committee
  def add_committee
    pr = PeopleRole.new
    pr.etd_id = params[:etd_id]
    pr.role_id = Role.find(:first, :conditions => "name = '" + params[:committee_type] + "'").id
    Person.find(params[:committee]).people_roles << pr

    respond_to do |format|
      format.html{ redirect_to(params[:origin] + params[:etd_id]) }
    end
  end
end
