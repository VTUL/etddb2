#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech.
# Last updated: Feb-11-2011
#########################################################

class SubmitController < ApplicationController

  def index_etd
    @etds = Etd.all
    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etds}
    end
  end

#GET /submit/new
#GET /submit/new.xml
  def new_etd
    @etd = Etd.new
    #begin
      @author = Person.find(:first,:conditions=>"pid='#{params[:author_pid]}' and role='author'")
    #rescue
      @author ||= Person.new
      @author.pid = params[:author_pid].to_s
      @author.roles << Role.find(:first,:conditions=>"name='author'") unless @author.roles.include? Role.find(:first, :conditions=>"name='author'")

    #end

    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etd}
    end
  end

  # POST /submit
  # POST /submit.xml
  def create_etd
    @etd = Etd.new(params[:etdl])
    @etd.urn = "etd-#{Time.now.month}#{Time.now.day}#{Time.now.year}-#{Time.now.hour}#{Time.now.min}#{Time.now.sec}"


    #@author = Person.find(params[:etdl_person_ids])
    #begin
      @author = Person.find(:first,:conditions=>"pid='#{@etd.pid}' and role='author'")
    #rescue

      @author ||= Person.new
      @author.pid = params[:etdl][:pid]
      @author.roles << Role.find(:first,:conditions=>"name='author'") unless @author.roles.include? Role.find(:first,:conditions=>"name='author'")
      @author.role = 'author'
      @author.save!
    #end
      @etd.people<<@author

    respond_to do |format|
      if @etd.save
        format.html { redirect_to(:controller => :submit, :action => :show_etd, :id=> @etd.id,:user_id=>@author.pid, :notice => 'Etd was successfully created.') }
        format.xml  { render :xml => @etd, :status => :created, :location => @etd }
      else
        format.html { render :action => "new_etd" }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /submit/show_etds_by_author
  def show_etds_by_author
    @session_id = session[:user_id]
    #begin
      @author = Person.find(:first, :conditions => "pid='#{@session_id}' and role='author'")
    #rescue
      @author ||= Person.new
      @author.pid = session[:user_id]
    #end
    @etdss = []

    respond_to do |format|
      if @author.nil?
        #format.html { redirect_to(:controller=>"sessions", :action=>"new",:author_pid=>@author.pid) }
        #format.html { redirect_to(:controller=>"submit", :action => "new_etd") }
        format.html {redirect_to( :controller => :people, :action => :new)}
      else
        @ability = Ability.new(@author)
        @etdss = @author.etds unless @author.etds.empty? unless @author.nil?

        format.html # show_etd_by_author.html.erb
        format.xml  { render :xml => @etd , :xml => @person }
      end
    end
  end

  def show_etd
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?

    respond_to do |format|
    # Update Etd attributes
      if @etd.update_attributes(params[:etd])
        unless @etd.availability.eql? "mixed"
          @etd.contents.each do |content|
            content.availability = @etd.availability
          end
        @etd.save!
        end
		format.html # show.html.erb
		format.xml  { render :xml => @etd , :xml => @person }
      else
        format.html { render :action => "edit_etd" }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /etds/1/edit
  def edit_etd
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
    respond_to do |format|
      if @etd.save
	      format.html # edit.html.erb
	      format.xml  { render :xml => @etd , :xml => @person }
      else
        format.html { render :action => "edit_etd" }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end
  end

  def delete_etd
    @etds = Etd.new
  end

  def edit_person
    @person = Person.find(params[:id])
  end

  def view_committee
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
    @chair = @etd.people.find(:first, :conditions => "role='committee_chair'") unless @etd.people.empty?
    @people = @etd.people.find(:all) unless @etd.people.empty?
  end

  def add_committee
    @etd = Etd.find(params[:id])
    @person = Person.new

    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etd}
    end
  end

  def create_committee
    @person = Person.new(params[:person])
    @etd = Etd.find(@person.etds.find(:last))
    @etd.people << @person

    respond_to do |format|
      if @person.save
        format.html { redirect_to(@person, :notice => 'Person was successfully created.') }
        format.xml  { render :xml => @person, :status => :created, :location => @person }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @person.errors, :status => :unprocessable_entity }
      end
    end
  end

  def add_files2
    @etd = Etd.new
    5.times { @etd.contents.build }
    #@content = Content.new
    #5.times { @content.build }
  end

  def edit_files2
    @etd = Etd.new
    5.times { @etd.contents.build }
    #@content = Content.new
    #5.times { @contents.build }
  end


  def add_files
    @picture = Content.new
    @etd = Etd.find(params[:id])
    #@etd.contents.each do |content|
       #content.delete if content.new_record?
    #end
  end

  def save_files
    @picture = Content.new(params[:content])
    @etd = Etd.find(params[:id])
    #5.times { @etd.contents.build }

    #if @picture.save
    if @etd.update_attributes(params[:etd])
      unless @etd.availability.eql? "mixed"
         @etd.contents.each do |content|
           content.availability = @etd.availability
         end
      end
      @etd.save!
#         params[:etd][:contents].each do |content|
#            @etd.contents[content.id].availability = content.availability
#        end
#	    format.html # show.html.erb
#	    format.xml  { render :xml => @etd , :xml => @person }

      #redirect_to(:action => 'show_files' , :id => @picture.etd_id)
      redirect_to(:action => 'show_files' , :id => @etd.id)
    else
      render(:action => :add_files)
    end
  end

  def show_files

    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
    @contents = nil
    @contents = Content.find(@etd.content_ids) unless @etd.contents.nil?

    respond_to do |format|
#      if @contents.update_attribute(params[:contents])
      if @etd.update_attributes(params[:etd])
      	#@etd.save
#        params[:etd][:contents].each do |content|
#            @etd.contents[content.id].availability = content.availability
#        end
	    format.html # show.html.erb
	    format.xml  { render :xml => @etd , :xml => @person }
      else
        format.html { render :action => "edit_etd" }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end

  end

  def delete_file
    @content = Content.find(params[:id])
    @id = @content.etd_id
    @content.delete

    respond_to do |format|
      #format.html
      format.html { redirect_to(:controller=>:submit, :action=>:show_files, :id=>@id) }
      format.xml  { head :ok }
    end
  end

  def content
    @picture = Content.find(params[:id])
    send_data(@picture.data,
    :filename => @picture.name,
    :types => @picture.content_type,
    :disposition => "inline" )
  end

  def change_availability
    @etd= Etd.find(params[:id])
  end

  def change_file_availability
    @etd1 = Etd.new(params[:etd])
    @etd= Etd.find(params[:id])
    @contents = @etd.contents.find(:all)
  end
end
