class PeopleController < ApplicationController
  respond_to :html, :json, :js

  # GET /people
  # GET /people.xml
  def index
    @people = Person.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render(xml: @people) }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    @person = Person.find(params[:id])
    @my_etds = Etd.find(@person.people_roles.where(role_id: Role.where(group: 'Creators')).pluck(:etd_id))
    @committee_etds = Etd.find(@person.people_roles.where(role_id: Role.where(group: 'Collaborators')).pluck(:etd_id))
    @reviewable_etds = Etd.where(status: "Submitted")

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render(xml: @person) }
    end
  end

  # POST /people/find/
  def find
    respond_to do |format|
      if params[:lname].nil?
        format.html { render(action: "find") }
      else
        format.js
        format.html { render(action: "new_committee_member") }
      end
    end
  end

  # POST /people/new_committee_member
  def new_committee_member
    respond_to do |format|
      format.html { render(action: "new_committee_member") }
    end
  end

  # POST /people/add_committee
  def add_committee
    pr = PeopleRole.new
    pr.etd_id = params[:etd_id]
    pr.role_id = Role.where(name: params[:committee_type]).first().id
    Person.find(params[:committee]).people_roles << pr

    # Whitelist params[:origin]
    origins = ["/etds/", "/etds/next_new/"]
    if !origins.include?(params[:origin])
      params[:origin] = "/etds/"
    end

    respond_to do |format|
      format.html { redirect_to(params[:origin] + params[:etd_id]) }
    end
  end
end
