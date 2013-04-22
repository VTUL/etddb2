class ReasonsController < ApplicationController
  before_filter :admin_only

  # GET /reasons
  # GET /reasons.json
  def index
    @reasons = Reason.where("name NOT IN (?)", Availability.pluck(:name))

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reasons }
    end
  end

  # GET /reasons/1
  # GET /reasons/1.json
  def show
    @reason = Reason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reason }
    end
  end

  # GET /reasons/new
  # GET /reasons/new.json
  def new
    @reason = Reason.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reason }
    end
  end

  # GET /reasons/1/edit
  def edit
    @reason = Reason.find(params[:id])

    unless @reason.availability.nil?
      redirect_to(edit_availability_path(@reason.availability))
    end
  end

  # POST /reasons
  # POST /reasons.json
  def create
    @reason = Reason.new(params[:reason])

    respond_to do |format|
      if @reason.save
        Provenance.create(person: current_person, action: "created", model: @reason)
        format.html { redirect_to @reason, notice: 'Reason was successfully created.' }
        format.json { render json: @reason, status: :created, location: @reason }
      else
        format.html { render action: "new" }
        format.json { render json: @reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reasons/1
  # PUT /reasons/1.json
  def update
    @reason = Reason.find(params[:id])

    respond_to do |format|
      if @reason.update_attributes(params[:reason])
        Provenance.create(person: current_person, action: "updated", model: @reason)
        format.html { redirect_to @reason, notice: 'Reason was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reason.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reasons/1
  # DELETE /reasons/1.json
  def destroy
    @reason = Reason.find(params[:id])

    unless @reason.availability.nil?
      redirect_to(reasons_url, notice: 'That Reason is attached to an Availability, and cannot be deleted.')
    end

    @reason.destroy

    Provenance.create(person: current_person, action: "destroyed", model: @reason)

    respond_to do |format|
      format.html { redirect_to reasons_url }
      format.json { head :no_content }
    end
  end
end
