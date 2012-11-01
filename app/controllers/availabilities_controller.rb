class AvailabilitiesController < ApplicationController
  # GET /availabilities
  # GET /availabilities.json
  def index
    @availabilities = Availability.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render(json: @availabilities) }
    end
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
    @availability = Availability.find(params[:id])
    @reason = Reason.where(name: @availability.name).first

    respond_to do |format|
      format.html # show.html.erb
      format.json { render(json: @availability) }
    end
  end

  # GET /availabilities/new
  # GET /availabilities/new.json
  def new
    @availability = Availability.new
    @reason = Reason.new()

    respond_to do |format|
      format.html # new.html.erb
      format.json { render(json: @availability) }
    end
  end

  # GET /availabilities/1/edit
  def edit
    @availability = Availability.find(params[:id])
    @reason = Reason.where(name: @availability.name).first
  end

  # POST /availabilities
  # POST /availabilities.json
  def create
    params[:availability][:retired] = false if params[:availability][:retired].nil?
    @availability = Availability.new(params[:availability])
    @reason = Reason.new(params[:reason])
    @reason.name = @availability.name 
    @reason.description =  "The default release schedule for #{@availability.name} ETDs."
    @availability.reason = @reason

    respond_to do |format|
      if  @reason.save && @availability.save
        Provenance.create(person: current_person, action: "created", model: @availability)

        format.html { redirect_to(@availability, notice: 'Availability was successfully created.') }
        format.json { render(json: @availability, status: :created, location: @availability) }
      else
        format.html { render(action: "new") }
        format.json { render(json: @availability.errors, status: :unprocessable_entity) }
      end
    end
  end

  # PUT /availabilities/1
  # PUT /availabilities/1.json
  def update
    @availability = Availability.find(params[:id])
    @reason = Reason.where(name: @availability.name).first

    respond_to do |format|
      if @availability.update_attributes(params[:availability]) && @reason.update_attributes(params[:reason])
        Provenance.create(person: current_person, action: "updated", model: @availability)

        format.html { redirect_to(@availability, notice: 'Availability was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render(action: "edit") }
        format.json { render(json: @availability.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    @availability = Availability.find(params[:id])
    @reason = Reason.where(name: @availability.name).first
    Provenance.create(person: current_person, action: "destroyed", model: @availability)
    @availability.destroy

    respond_to do |format|
      format.html { redirect_to(availabilities_url) }
      format.json { head :ok }
    end
  end
end
