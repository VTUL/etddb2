class DegreesController < ApplicationController
  require 'pagination_helpers'
  # GET /degrees
  # GET /degrees.json
  def index
    @per_page = Pagination_Helper.sanitize_per_page(params[:per_page])
    @degrees = Degree.paginate(page: params[:page], per_page: @per_page)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render(json: @degrees) }
    end
  end

  # GET /degrees/1
  # GET /degrees/1.json
  def show
    @degree = Degree.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render(json: @degree) }
    end
  end

  # GET /degrees/new
  # GET /degrees/new.json
  def new
    @degree = Degree.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render(json: @degree) }
    end
  end

  # GET /degrees/1/edit
  def edit
    @degree = Degree.find(params[:id])
  end

  # POST /degrees
  # POST /degrees.json
  def create
    @degree = Degree.new(params[:degree])

    respond_to do |format|
      if @degree.save
        Provenance.create(person: current_person, action: "created", model: @degree)

        format.html { redirect_to(@degree, notice: 'Degree was successfully created.') }
        format.json { render(json: @degree, status: :created, location: @degree) }
      else
        format.html { render(action: "new") }
        format.json { render(json: @degree.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /degrees/1
  # PUT /degrees/1.json
  def update
    @degree = Degree.find(params[:id])

    respond_to do |format|
      if @degree.update_attributes(params[:degree])
        Provenance.create(person: current_person, action: "updated", model: @degree)

        format.html { redirect_to(@degree, notice: 'Degree was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render(action: "edit") }
        format.json { render(json: @degree.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /degrees/1
  # DELETE /degrees/1.json
  def destroy
    @degree = Degree.find(params[:id])
    Provenance.create(person: current_person, action: "destroyed", model: @degree)
    @degree.destroy

    respond_to do |format|
      format.html { redirect_to(degrees_url) }
      format.json { head :ok }
    end
  end
end
