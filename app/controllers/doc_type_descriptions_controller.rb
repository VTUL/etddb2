class DocTypeDescriptionsController < ApplicationController
  # GET /doc_type_descriptions
  # GET /doc_type_descriptions.xml
  def index
    @doc_type_descriptions = DocTypeDescription.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @doc_type_descriptions }
    end
  end

  # GET /doc_type_descriptions/1
  # GET /doc_type_descriptions/1.xml
  def show
    @doc_type_description = DocTypeDescription.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @doc_type_description }
    end
  end

  # GET /doc_type_descriptions/new
  # GET /doc_type_descriptions/new.xml
  def new
    @doc_type_description = DocTypeDescription.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @doc_type_description }
    end
  end

  # GET /doc_type_descriptions/1/edit
  def edit
    @doc_type_description = DocTypeDescription.find(params[:id])
  end

  # POST /doc_type_descriptions
  # POST /doc_type_descriptions.xml
  def create
    @doc_type_description = DocTypeDescription.new(params[:doc_type_description])

    respond_to do |format|
      if @doc_type_description.save
        format.html { redirect_to(@doc_type_description, :notice => 'DocTypeDescription was successfully created.') }
        format.xml  { render :xml => @doc_type_description, :status => :created, :location => @doc_type_description }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @doc_type_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /doc_type_descriptions/1
  # PUT /doc_type_descriptions/1.xml
  def update
    @doc_type_description = DocTypeDescription.find(params[:id])

    respond_to do |format|
      if @doc_type_description.update_attributes(params[:doc_type_description])
        format.html { redirect_to(@doc_type_description, :notice => 'DocTypeDescription was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @doc_type_description.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /doc_type_descriptions/1
  # DELETE /doc_type_descriptions/1.xml
  def destroy
    @doc_type_description = DocTypeDescription.find(params[:id])
    @doc_type_description.destroy

    respond_to do |format|
      format.html { redirect_to(doc_type_descriptions_url) }
      format.xml  { head :ok }
    end
  end
end
