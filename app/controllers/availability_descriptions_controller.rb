
class AvailabilityDescriptionsController < ApplicationController
  # GET /availability_descriptions
  # GET /availability_descriptions.xml
  def index
    @availability_descriptions = AvailabilityDescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @availability_descriptions }
    end
  end

  # GET /availability_descriptions/1
  # GET /availability_descriptions/1.xml
  def show
    @availability_description = AvailabilityDescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @availability_description }
    end
  end

  # GET /availability_descriptions/new
  # GET /availability_descriptions/new.xml
  def new
    @availability_description = AvailabilityDescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @availability_description }
    end
  end

  # GET /availability_descriptions/1/edit
  def edit
    @availability_description = AvailabilityDescription.find(params[:id])
  end

  # POST /availability_descriptions
  # POST /availability_descriptions.xml
  def create
    @availability_description = AvailabilityDescription.new(params[:availability_description])

    respond_to do |format|
      if @availability_description.save
        format.html { redirect_to(@availability_description, :notice => 'AvailabilityDescription was successfully created.') }
        format.xml  { render :xml => @availability_description, :status => :created, :location => @availability_description }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @availability_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /availability_descriptions/1
  # PUT /availability_descriptions/1.xml
  def update
    @availability_description = AvailabilityDescription.find(params[:id])

    respond_to do |format|
      if @availability_description.update_attributes(params[:availability_description])
        format.html { redirect_to(@availability_description, :notice => 'AvailabilityDescription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @availability_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /availability_descriptions/1
  # DELETE /availability_descriptions/1.xml
  def destroy
    @availability_description = AvailabilityDescription.find(params[:id])
    @availability_description.destroy

    respond_to do |format|
      format.html { redirect_to(availability_descriptions_url) }
      format.xml  { head :ok }
    end
  end
end
