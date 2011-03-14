class DegreeDescriptionsController < ApplicationController
  # GET /degree_descriptions
  # GET /degree_descriptions.xml
  def index
    @degree_descriptions = DegreeDescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @degree_descriptions }
    end
  end

  # GET /degree_descriptions/1
  # GET /degree_descriptions/1.xml
  def show
    @degree_description = DegreeDescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @degree_description }
    end
  end

  # GET /degree_descriptions/new
  # GET /degree_descriptions/new.xml
  def new
    @degree_description = DegreeDescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @degree_description }
    end
  end

  # GET /degree_descriptions/1/edit
  def edit
    @degree_description = DegreeDescription.find(params[:id])
  end

  # POST /degree_descriptions
  # POST /degree_descriptions.xml
  def create
    @degree_description = DegreeDescription.new(params[:degree_description])

    respond_to do |format|
      if @degree_description.save
        format.html { redirect_to(@degree_description, :notice => 'DegreeDescription was successfully created.') }
        format.xml  { render :xml => @degree_description, :status => :created, :location => @degree_description }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @degree_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /degree_descriptions/1
  # PUT /degree_descriptions/1.xml
  def update
    @degree_description = DegreeDescription.find(params[:id])

    respond_to do |format|
      if @degree_description.update_attributes(params[:degree_description])
        format.html { redirect_to(@degree_description, :notice => 'DegreeDescription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @degree_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /degree_descriptions/1
  # DELETE /degree_descriptions/1.xml
  def destroy
    @degree_description = DegreeDescription.find(params[:id])
    @degree_description.destroy

    respond_to do |format|
      format.html { redirect_to(degree_descriptions_url) }
      format.xml  { head :ok }
    end
  end
end
