class RolesController < ApplicationController

  require 'pagination_helpers'
  before_filter :admin_only

  # GET /roles
  # GET /roles.xml
  def index
    @per_page = Pagination_Helper.sanitize_per_page(params[:per_page])
    @roles = Role.paginate(:page => params[:page], per_page: @per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render(xml: @roles) }
    end
  end

  # GET /roles/1
  # GET /roles/1.xml
  def show
    @role = Role.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @role) }
    end
  end

  # GET /roles/new
  # GET /roles/new.xml
  def new
    @role = Role.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @role) }
    end
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /roles
  # POST /roles.xml
  def create
    @role = Role.new(params[:role])

    respond_to do |format|
      if @role.save
        Provenance.create(person: current_person, action: "created", model: @role)

        format.html { redirect_to(@role, notice: 'Role was successfully created.') }
        format.xml  { render(xml: @role, status: :created, location: @role) }
      else
        format.html { render(action: "new") }
        format.xml  { render(xml: @role.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /roles/1
  # PUT /roles/1.xml
  def update
    @role = Role.find(params[:id])

    respond_to do |format|
      if @role.update_attributes(params[:role])
        Provenance.create(person: current_person, action: "updated", model: @role)

        format.html { redirect_to(@role, notice: 'Role was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "edit") }
        format.xml  { render(xml: @role.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.xml
  def destroy
    @role = Role.find(params[:id])
    Provenance.create(person: current_person, action: "destroyed", model: @role)
    @role.destroy

    respond_to do |format|
      format.html { redirect_to(roles_url) }
      format.xml  { head :ok }
    end
  end
end
