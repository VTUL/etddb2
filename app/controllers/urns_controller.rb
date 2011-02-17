class UrnsController < ApplicationController
  # GET /urns
  # GET /urns.xml
  def index
    @urns = Urn.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @urns }
    end
  end

  # GET /urns/1
  # GET /urns/1.xml
  def show
    @urn = Urn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @urn }
    end
  end

  # GET /urns/new
  # GET /urns/new.xml
  def new
    @urn = Urn.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @urn }
    end
  end

  # GET /urns/1/edit
  def edit
    @urn = Urn.find(params[:id])
  end

  # POST /urns
  # POST /urns.xml
  def create
    @urn = Urn.new(params[:urn])

    respond_to do |format|
      if @urn.save
        format.html { redirect_to(@urn, :notice => 'URN was successfully created.') }
        format.xml  { render :xml => @urn, :status => :created, :location => @urn }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @urn.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /urns/1
  # PUT /urns/1.xml
  def update
    @urn = Urn.find(params[:id])

    respond_to do |format|
      if @urn.update_attributes(params[:urn])
        format.html { redirect_to(@urn, :notice => 'URN was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @urn.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /urns/1
  # DELETE /urns/1.xml
  def destroy
    @urn = Urn.find(params[:id])
    @urn.destroy

    respond_to do |format|
      format.html { redirect_to(urns_url) }
      format.xml  { head :ok }
    end
  end
end
