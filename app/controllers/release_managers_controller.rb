class ReleaseManagersController < ApplicationController
  # GET /release_managers
  # GET /release_managers.json
  def index
    @release_managers = ReleaseManager.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @release_managers }
    end
  end

  # GET /release_managers/1
  # GET /release_managers/1.json
  def show
    @release_manager = ReleaseManager.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @release_manager }
    end
  end

  # GET /release_managers/new
  # GET /release_managers/new.json
  def new
    @release_manager = ReleaseManager.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @release_manager }
    end
  end

  # GET /release_managers/1/edit
  def edit
    @release_manager = ReleaseManager.find(params[:id])
  end

  # POST /release_managers
  # POST /release_managers.json
  def create
    @release_manager = ReleaseManager.new(params[:release_manager])

    respond_to do |format|
      if @release_manager.save
        format.html { redirect_to @release_manager, notice: 'Release manager was successfully created.' }
        format.json { render json: @release_manager, status: :created, location: @release_manager }
      else
        format.html { render action: "new" }
        format.json { render json: @release_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /release_managers/1
  # PUT /release_managers/1.json
  def update
    @release_manager = ReleaseManager.find(params[:id])

    respond_to do |format|
      if @release_manager.update_attributes(params[:release_manager])
        format.html { redirect_to @release_manager, notice: 'Release manager was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @release_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /release_managers/1
  # DELETE /release_managers/1.json
  def destroy
    @release_manager = ReleaseManager.find(params[:id])
    @release_manager.destroy

    respond_to do |format|
      format.html { redirect_to release_managers_url }
      format.json { head :no_content }
    end
  end
end
