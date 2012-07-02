class ContentsController < ApplicationController
  #require 'mime/types'
  # GET /contents
  # GET /contents.xml
  def index
    respond_to do |format|
      @authors_etds = current_person.etds
      format.html # index.html.erb
      format.xml  { render(xml: @authors_etds) }
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
  end

  # POST /contents
  # POST /contents.xml
  def create
    @etd = Etd.find(params[:etd_id])
    @content = Content.new(params[:content])

    if @content.availability_id.nil? && @content.availability.nil?
      @content.availability = @etd.availability
    end
    @content.etd = @etd
    @content.bound = @etd.bound
    
    respond_to do |format|
      if @content.save
        Provenance.create(person: current_person, action: "created", model: @content)
        @etd.contents << @content
        # Update the ETD's availability.
        if @content.availability_id != @etd.availability_id && @etd.availability.name != "Mixed"
          @etd.availability_id = Availability.where(name: "Mixed").first.id
          @etd.save
        end

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
    @etd = @content.etd

    respond_to do |format|
      if @content.update_attributes(params[:content])
        Provenance.create(person: current_person, action: "updated", model: @content)

        # Update the ETD's availability.
        if @content.availability_id != @etd.availability_id
          avails = @etd.contents.pluck(:availability_id).uniq
          if avails.length == 1
            @etd.availability_id = avails[0]
          else
            @etd.availability_id = Availability.where(name: "Mixed").first.id
          end
          @etd.save
        end

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
    Provenance.create(person: current_person, action: "deleted", model: @content)
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_path) }
      format.xml  { head :ok }
    end
  end

end
