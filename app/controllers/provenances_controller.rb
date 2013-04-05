class ProvenancesController < ApplicationController
  require 'pagination_helpers'
  # GET /provenances
  # GET /provenances.xml
  def index
    @per_page = Pagination_Helper.sanitize_per_page(params[:per_page])

    @person_is_admin = current_person.in_role_group?('Administration')
    @provenances = nil
    if @person_is_admin
      @provenances = Provenance.where('id not null')
    else
      @provenances = Provenance.where(person_id: current_person.id)
    end
    if params[:type].nil?
      @provenances = @provenances.paginate(:page => params[:page], per_page: @per_page, order: ['id DESC'])
    else
      @provenances = @provenances.where(model_type: params[:type]).paginate(:page => params[:page], per_page: @per_page, order: ['id DESC'])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render(xml: @provenances) }
    end
  end

  # GET /provenances/1
  # GET /provenances/1.xml
  def show
    @provenance = Provenance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @provenance) }
    end
  end

  # GET /provenances/new
  # GET /provenances/new.xml
  def new
    @provenance = Provenance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @provenance) }
    end
  end

  # GET /provenances/1/edit
  def edit
    @provenance = Provenance.find(params[:id])
  end

  # POST /provenances
  # POST /provenances.xml
  def create
    @provenance = Provenance.new(params[:provenance])

    respond_to do |format|
      if @provenance.save
        format.html { redirect_to(@provenance, notice: 'Provenance was successfully created.') }
        format.xml  { render(xml: @provenance, status: :created, location: @provenance) }
      else
        format.html { render(action: "new") }
        format.xml  { render(xml: @provenance.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /provenances/1
  # PUT /provenances/1.xml
  def update
    @provenance = Provenance.find(params[:id])

    respond_to do |format|
      if @provenance.update_attributes(params[:provenance])
        format.html { redirect_to(@provenance, notice: 'Provenance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render(action: "edit") }
        format.xml  { render(xml: @provenance.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /provenances/1
  # DELETE /provenances/1.xml
  def destroy
    @provenance = Provenance.find(params[:id])
    @provenance.destroy

    respond_to do |format|
      format.html { redirect_to(provenances_url) }
      format.xml  { head :ok }
    end
  end
end
