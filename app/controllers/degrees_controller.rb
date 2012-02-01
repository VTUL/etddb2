class DegreesController < ApplicationController
  # GET /degrees
  # GET /degrees.json
  def index
    @degrees = Degree.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @degrees }
    end
  end

  # GET /degrees/1
  # GET /degrees/1.json
  def show
    @degree = Degree.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @degree }
    end
  end

  # GET /degrees/new
  # GET /degrees/new.json
  def new
    @degree = Degree.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @degree }
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
        format.html { redirect_to @degree, notice: 'Degree was successfully created.' }
        format.json { render json: @degree, status: :created, location: @degree }
      else
        format.html { render action: "new" }
        format.json { render json: @degree.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /degrees/1
  # PUT /degrees/1.json
  def update
    @degree = Degree.find(params[:id])

    respond_to do |format|
      if @degree.update_attributes(params[:degree])
        format.html { redirect_to @degree, notice: 'Degree was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @degree.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /degrees/1
  # DELETE /degrees/1.json
  def destroy
    @degree = Degree.find(params[:id])
    @degree.destroy

    respond_to do |format|
      format.html { redirect_to degrees_url }
      format.json { head :ok }
    end
  end
end
