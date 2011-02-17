class DigitalObjectsController < ApplicationController
  # GET /digital_objects
  # GET /digital_objects.xml
  def index
    @digital_objects = DigitalObject.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @digital_objects }
    end
  end

  # GET /digital_objects/1
  # GET /digital_objects/1.xml
  def show
    @digital_object = DigitalObject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @digital_object }
    end
  end

  # GET /digital_objects/new
  # GET /digital_objects/new.xml
  def new
    @digital_object = DigitalObject.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @digital_object }
    end
  end

  # GET /digital_objects/1/edit
  def edit
    @digital_object = DigitalObject.find(params[:id])
  end

  # POST /digital_objects
  # POST /digital_objects.xml
  def create
    @digital_object = DigitalObject.new(params[:digital_object])

    respond_to do |format|
      if @digital_object.save
        format.html { redirect_to(@digital_object, :notice => 'DigitalObject was successfully created.') }
        format.xml  { render :xml => @digital_object, :status => :created, :location => @digital_object }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @digital_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /digital_objects/1
  # PUT /digital_objects/1.xml
  def update
    @digital_object = DigitalObject.find(params[:id])

    respond_to do |format|
      if @digital_object.update_attributes(params[:digital_object])
        format.html { redirect_to(@digital_object, :notice => 'DigitalObject was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @digital_object.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /digital_objects/1
  # DELETE /digital_objects/1.xml
  def destroy
    @digital_object = DigitalObject.find(params[:id])
    @digital_object.destroy

    respond_to do |format|
      format.html { redirect_to(digital_objects_url) }
      format.xml  { head :ok }
    end
  end
end
