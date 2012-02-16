class ContentsController < ApplicationController
  # GET /contents
  # GET /contents.xml
  def index
    @contents = Content.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contents }
    end
  end

  # GET /contents/1
  # GET /contents/1.xml
  def show
    @content = Content.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/new
  # GET /contents/new.xml
  def new
    @content = Content.new
    @etd = Etd.find(params[:etd_id])
    @contents = @etd.contents.find(:all)

    5.times { @etd.contents.build }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  # GET /contents/1/edit.xml
  def edit
    @content = Content.find(params[:id])
    @etd = Etd.find(@content.etd_id)
    @contents = @etd.contents.find(:all)

    5.times { @etd.contents.build }
  end

  # POST /contents
  # POST /contents.xml
  def create
    @content = Content.new(params[:content])
    @etd = Etd.find(params[:etd_id])
    @etd.contents << @content

    respond_to do |format|
      if @content.save
        format.html { redirect_to(@content, :notice => 'Content was successfully created.') }
        format.xml  { render :xml => @content, :status => :created, :location => @content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # POST /contents/edit
  # POST /contents/edit.xml
  def update
  # fetch objects to be use in the view
    @etd = Etd.find(params[:etd_id])
    @content = Content.new(params[:content])


    # check if there is any change or update of picture/etd itself
    if @content.save
        @etd.contents << @content
    end

    # for mixed case of etds
    if @etd.update_attributes(params[:etd])
      # in case of changing etd avaiability
      unless @etd.availability.name.eql? "Mixed"
         @etd.contents.each do |content|
           content.availability = @etd.availability
         end
      end
      @etd.save!
      # handling each content availability
      redirect_to(:action => 'my_contents')
    else
      render(:action => :add_files)
    end
  end

  # DELETE /contents/1
  # DELETE /contents/1.xml
  def destroy
    @content = Content.find(params[:id])
    @content.destroy

    respond_to do |format|
      format.html { redirect_to(contents_url) }
      format.xml  { head :ok }
    end
  end

  def my_contents
    respond_to do |format|
      # This should be implemented in a before_filter
      if person_signed_in?
        @authors_etds = current_person.etds

        format.html # show_etd_by_author.html.erb
        format.xml  { render :xml => @authors_etds , :xml => @person }
      else
        format.html {redirect_to(login_path, :notice => "You need to login to browse your ETDs.")}
      end
    end
  end

  def add_contents
    @content = Content.new
    @etd = Etd.find(params[:etd_id])
    @contents = @etd.contents.find(:all)

    5.times { @etd.contents.build }
  end

  def change_availability
    @etd1 = Etd.new(params[:etd])
    @etd= Etd.find(params[:id])
    @contents = @etd.contents.find(:all)
  end

end
