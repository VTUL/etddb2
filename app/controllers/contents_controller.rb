class ContentsController < ApplicationController
  require 'mime/types' 
  # GET /contents
  # GET /contents.xml
  def index
    respond_to do |format|
      # This should be implemented in a before_filter
      if person_signed_in?
        @authors_etds = current_person.etds

        format.html # show_etd_by_author.html.erb
        format.xml  { render(xml: @authors_etds , xml: @person) }
      else
        format.html { redirect_to(login_path, notice: "You need to login to browse your contents.") }
      end
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])
    @etd = Etd.find(@content.etd_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render(xml: @content) }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new
    @etd = Etd.find(params[:etd_id])
    @contents = @etd.contents.find(:all)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render(xml: @content) }
    end
  end

  # GET /contents/1/edit
  # GET /contents/1/edit.xml
  def edit
    @content = Content.find(params[:id])
    @etd = Etd.find(@content.etd_id)
    @contents = @etd.contents.find(:all)
  end

  # POST /contents
  # POST /contents.xml
  def create
    @etd = Etd.find(params[:etd_id])
    @content = Content.new(params[:content])

    @content.availability = @etd.availability
    @content.etd = @etd
    @content.bound = @etd.bound
    
    respond_to do |format|
      if @content.save
        @etd.contents << @content
        format.html { redirect_to(@content, notice: 'Content was successfully created.') }
      else 
        format.html { render(action: "new") }
      end
    end
  end

  # POST /contents/edit
  # POST /contents/edit.xml
  def update
    @content = Content.find(params[:id])
    # The below are needed in case we need to render the edit page again (ie. if there are errors).
    @etd = Etd.find(@content.etd_id)
    @contents = @etd.contents.find(:all)

    respond_to do |format|
      if @content.update_attributes(params[:content])
        format.html { redirect_to(@content, notice: 'Content was successfully updated.') }
        format.json { head :ok }
      else
        format.html { render(action: "edit") }
        format.json { render(json: @document_type.errors, status: :unprocessable_entity) }
      end
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(my_contents_path) }
      format.xml  { head :ok }
    end
  end

end
