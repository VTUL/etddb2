class ContentsController < ApplicationController
  #require 'mime/types'
  # GET /contents
  # GET /contents.xml
  def index
    @authors_etds = current_person.etds
    respond_to do |format|
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
        format.json { render(json: @content.errors, status: :unprocessable_entity) }
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

  # GET /available/etd-00000000-00000000/available/filename.format?12345678
  def get_file
    @etd = Etd.where(urn: params[:urn]).first
    params[:filename] += ".#{params[:format]}" unless params[:format].nil?
    @content = @etd.contents.where(content_file_name: params[:filename]).first unless @etd.nil?

    correct_avail = !@etd.nil? && params[:availability] == @etd.availability.name.downcase()
    correct_avail &= !@content.nil? && params[:file_availability] == @content.availability.name.downcase()
    if correct_avail
      send_file(@content.content.path, filename: @content.content_file_name, type: @content.content_content_type)
    else
      # Bad URN, or wrong availability, or bad filename.
      # TODO: Split this up to handle individual cases
      render # get_file.html.erb
    end
  end
end
