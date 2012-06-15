class PeopleRolesController < ApplicationController
  respond_to :html, :json, :js

  # GET /people_roles
  # GET /people_roles.xml
  def index
    @people_roles = PeopleRole.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render(xml: @people_roles) }
    end
  end

  # GET /people_roles/1
  # GET /people_roles/1.xml
  def show
    @people_role = PeopleRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @people_role) }
    end
  end

  # GET /people_roles/new
  # GET /people_roles/new.xml
  def new
    @people_role = PeopleRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @people_role) }
    end
  end

  # GET /people_roles/1/edit
  def edit
    @people_role = PeopleRole.find(params[:id])
  end

  # POST /people_roles
  # POST /people_roles.xml
  def create
    @people_role = PeopleRole.new(params[:people_role])

    respond_to do |format|
      if @people_role.save
        format.html { redirect_to(@people_role, notice: 'PeopleRole was successfully created.') }
        format.xml  { render(xml: @people_role, status: :created, location: @people_role) }
      else
        format.html { render(action: "new") }
        format.xml  { render(xml: @people_role.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /people_roles/1
  # PUT /people_roles/1.xml
  def update
    @people_role = PeopleRole.find(params[:id])

    if params[:vote] == ''
      params[:vote] = nil
    elsif params[:vote] == 'true'
      params[:vote] = true
    elsif params[:vote] == 'false'
      params[:vote] = false
    end

    respond_to do |format|
      if @people_role.update_attributes(params[:people_role])
        format.html { redirect_to(@people_role, notice: 'PeopleRole was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "edit") }
        format.xml  { render(xml: @people_role.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /people_roles/1
  # DELETE /people_roles/1.xml
  def destroy
    @people_role = PeopleRole.find(params[:id])
    @people_role.destroy

    respond_to do |format|
      format.html { redirect_to(people_roles_url) }
      format.xml { head :ok }
      format.js { render(nothing: true) }
    end
  end
end
