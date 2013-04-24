class DocumentTypesController < ApplicationController

  require 'pagination_helpers'
  before_filter :admin_only

  # GET /document_types
  # GET /document_types.json
  def index
    @per_page = Pagination_Helper.sanitize_per_page(params[:per_page])
    @document_types = DocumentType.paginate(page: params[:page], per_page: @per_page).order('name ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render(json: @document_types) }
    end
  end

  # GET /document_types/1
  # GET /document_types/1.json
  def show
    @document_type = DocumentType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render(json: @document_type) }
    end
  end

  # GET /document_types/new
  # GET /document_types/new.json
  def new
    @document_type = DocumentType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render(json: @document_type) }
    end
  end

  # GET /document_types/1/edit
  def edit
    @document_type = DocumentType.find(params[:id])
  end

  # POST /document_types
  # POST /document_types.json
  def create
    @document_type = DocumentType.new(params[:document_type])

    respond_to do |format|
      if @document_type.save
        Provenance.create(person: current_person, action: "created", model: @document_type)

        format.html { redirect_to(@document_type, notice: 'Document type was successfully created.') }
        format.json { render(json: @document_type, status: :created, location: @document_type) }
      else
        format.html { render(action: "new") }
        format.json { render(json: @document_type.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /document_types/1
  # PUT /document_types/1.json
  def update
    @document_type = DocumentType.find(params[:id])

    respond_to do |format|
      if @document_type.update_attributes(params[:document_type])
        Provenance.create(person: current_person, action: "updated", model: @document_type)

        format.html { redirect_to(@document_type, notice: 'Document type was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render(action: "edit") }
        format.json { render(json: @document_type.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /document_types/1
  # DELETE /document_types/1.json
  def destroy
    @document_type = DocumentType.find(params[:id])
    Provenance.create(person: current_person, action: "destroyed", model: @document_type)
    @document_type.destroy

    respond_to do |format|
      format.html { redirect_to(document_types_url) }
      format.json { head :ok }
    end
  end
end
