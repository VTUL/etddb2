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


#    @content = Content.find(params[:id])

#    @picture = Content.new
#    @etd = Etd.find(params[:id])
    @etd = Etd.find(params[:etd_id])
    @contents = @etd.contents.find(:all)

    #@content = Content.new
    #5.times { @content.build }
    5.times { @etd.contents.build }
    #@etd.contents.each do |content|
    #   content.delete if content.new_record?
    #end

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @content }
    end
  end

  # GET /contents/1/edit
  def edit
#    @content = Content.find(params[:id])

#    @picture = Content.new
#    @etd = Etd.find(params[:id])
    @etd = Etd.find(params[:etd_id])
    @contents = @etd.contents.find(:all)

    #@content = Content.new
    #5.times { @content.build }
    5.times { @etd.contents.build }
    #@etd.contents.each do |content|
    #   content.delete if content.new_record?
    #end
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

  # PUT /contents/1
  # PUT /contents/1.xml
#  def update
#  	@etd = Etd.find(params[:etd_id])
#    @content = @etd.contents
#    #@content = Content.find(params[:id])

#    respond_to do |format|
#      if @etd.update_attributes(params[:content])
#        format.html { redirect_to(@content, :notice => 'Content was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @content.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

#
  def update
  # fetch objects to be use in the view
    @etd = Etd.find(params[:etd_id])
    @content = Content.new(params[:content])


    # check if there is any change or update of picture/etd itself
    if @content.save
        #puts "this is picture.save\n"
        @etd.contents<< @content
    else
        #puts "this is not picture.save\n"
    end

   #  @picture = Content.new(params[:etd][:contents][:uploaded_picture])
   #      @picture.save
   #      @etd.contents<< @picture
   #  @etd.save

  # add 5 contents build?? Check up this line code
  # 5.times { @etd.contents.build }


    # for mixed case of etds
    if @etd.update_attributes(params[:etd])
      # in case of changing etd avaiability
      unless @etd.availability.name.eql? "Mixed"
         @etd.contents.each do |content|
           content.availability_id = @etd.availability_id
         end
      end
      @etd.save!
      # handling each content availability
      ######################################################
      # Now I am commenting out these codes for a while. If there is no problem, these code should be removed.
      # params[:etd][:contents].each do |content|
      #    @etd.contents[content.id].availability = content.availability
      #end
      ########################################################
      #format.html #{ render :action => "show_files.html.erb" }
      #format.xml  { render :xml => @etd , :xml => @person }

      #redirect_to(:action => 'show_files' , :id => @picture.etd_id)
      redirect_to(:action => 'my_contents' , :id => @etd.id)
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
        # This does not work. Need to get Etds from PeopleRoles table, but nothing is being stored there.
        @authors_etds = current_person.etds

        format.html # show_etd_by_author.html.erb
        format.xml  { render :xml => @authors_etds , :xml => @person }
      else
        format.html {redirect_to(login_path, :notice => "You need to login to browse your ETDs.")}
      end
    end
  end

  def add_contents
    @picture = Content.new
    @etd = Etd.find(params[:id])
    @contents = @etd.contents.find(:all)

    #@content = Content.new
    #5.times { @content.build }
    5.times { @etd.contents.build }
    #@etd.contents.each do |content|
    #   content.delete if content.new_record?
    #end
  end

  def change_availability
    @etd1 = Etd.new(params[:etd])
    @etd= Etd.find(params[:id])
    @contents = @etd.contents.find(:all)
  end

end
