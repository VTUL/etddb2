class ContentsController < ApplicationController
  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])
    @etd = @content.etd

    respond_to do |format|
      # TODO: Should anyone associated with the ETD have unfettered access, or just the creators and collaborators?
      if Etd::ACCESS.matches?(request.ip, @etd.availability, @content.availability, current_person) || @etd.people.include?(current_person)
        format.html # show.html.erb
        format.xml  { render(xml: @content) }
      else
        # TODO: Perhaps log IPs that are hitting these pages?
        redirect_to(etds_path, notice: 'Access to that ETD is restriced.')
      end
    end
  end

  # GET /available/etd-00000000-00000000/available/filename.format?12345678
  def old_show
    @etd = Etd.where(urn: params[:urn]).first
    params[:filename] += ".#{params[:format]}" unless params[:format].nil?

    if !@etd.nil?
      @content = @etd.contents.where(content_file_name: params[:filename]).first
      if !@content.nil?
        redirect_to(content_path(@content), status: :moved_permanently)
      else
        redirect_to(etd_path(@etd), notice: 'That file does not seem to exist. Check below.')
      end
    else
      # TODO: Should redirect to the advanced search page?
      redirect_to(etds_path, notice: "I can't find that ETD, but you can search for it here.")
    end
  end

  # GET /contents/1/download
  def download
    @content = Content.find(params[:id])
    @etd = @content.etd

    # TODO: Should anyone associated with the ETD have unfettered access, or just the creators and collaborators?
    if Etd::ACCESS.matches?(request.ip, @etd.availability, @content.availability, current_person) || @etd.people.include?(current_person)
      send_file(@content.content.path, filename: @content.content_file_name, type: @content.content_content_type)
    else
      # TODO: Perhaps log IPs that are hitting these pages?
      redirect_to(etds_path, notice: 'Access to that ETD is restriced.')
    end
  end

  # GET /contents/1/edit
  # GET /contents/1/edit.xml
  def edit
    @content = Content.find(params[:id])
    @etd = Etd.find(@content.etd_id)
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
        if @content.availability != @etd.availability
          avails = @etd.contents.pluck(:availability_id).uniq
          if avails.length == 1
            @etd.availability_id = avails[0]
          else
            @etd.availability = Availability.where(retired: false, etd_only: true).first if !@etd.availability.etd_only
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
    @etd = @content.etd
    Provenance.create(person: current_person, action: "deleted", model: @content)
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(etd_contents_path(@etd)) }
      format.xml  { head(:ok) }
    end
  end

  # POST /contents/1/update_availability
  def update_availability
    @content = Content.find(params[:id])

    @content.availability = Availability.find(params[:availability_id])
    if @content.availability.allows_reasons? && !params[:reason_id].empty?
      @content.reason = Reason.find(params[:reason_id])
    else
      @content.reason = @content.availability.reason
    end

    respond_to do |format|
      if @content.save
        Provenance.create(person: current_person, action: "updated the availability for", model: @content)
        format.html { redirect_to(etd_contents_path(@content.etd), notice: 'Updated Content.') }
      else
        format.html { redirect_to(etd_contents_path(@content.etd), notice: "Something's not right...") }
      end
    end
  end
end
