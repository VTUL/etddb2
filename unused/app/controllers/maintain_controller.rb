#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-16-2011
#########################################################
class MaintainController < ApplicationController
  # Show all etds in the maintain queue
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
    @author = Person.find(params[:author_id])

    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etd}
    end
  end

  # POST /submit
  # POST /submit.xml
  def create_etd
    @etd = Etd.new(params[:etd])
    @author = Person.find(params[:etd_person_ids])
    respond_to do |format|
      if @etd.save
        format.html { redirect_to(:controller => :submit, :action => :show_etd, :notice => 'Etd was successfully created.') }
        format.xml  { render :xml => @etd, :status => :created, :location => @etd }
      else
        format.html { render :action => "new_etd" }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end
  end

 
  # GET /submit/show_etds_by_author
  # show all etds by author
  def show_etds_by_author
    @author = Person.find(:first, :conditions => "pid='#{params[:pid]}'")
    @etdss = Etd.find(@author.etd_ids) unless @author.etd_ids.empty?

    respond_to do |format|
      format.html # show_etd_by_author.html.erb
      format.xml  { render :xml => @etd , :xml => @person }
    end
  end
  # GET /maintain/1/show_etd
  # Show each etd by id
  def show_etd
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @etd , :xml => @person }
    end
  end

  # GET /etds/1/edit
  def edit_etd
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
  end

  # GET /maintain/1/delete_etd
  def delete_etd
    @etd = Etd.find(params[:id])
    @etd.destroy unless @etd.empty?
  end
  
  # GET /maintain/1/edit_person
  def edit_person
    @person = Person.find(params[:id])
  end

  # GET /maintain/1/view_committee
  def view_committee
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
    @chair = @etd.people.find(:first, :conditions => "role='committee_chair'") unless @etd.people.empty?
    @people = @etd.people.find(:all) unless @etd.people.empty?
  end

  # GET /maintain/1/add_committee
  def add_committee
    @etd = Etd.find(params[:id])
    @person = Person.new

    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etd}
    end
  end

  # GET /maintain/1/create_committee
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

  # GET /maintain/1/add_files
  def add_files
    @picture = Content.new
    @etd = Etd.find(params[:id])
  end

  # GET /maintain/1/save_files
  def save_files
    @picture = Content.new(params[:content])
    if @picture.save
      redirect_to(:action => 'show_files' , :id => @picture.etd_id)
    else
      render(:action => :add_files)
    end
  end

  # GET /maintain/1/show_files
  def show_files 
    @etd = Etd.find(params[:id])
    @contents = Content.find(@etd.content_ids) unless @etd.contents.empty?
  end


  # GET /maintain/1/content
  def content
    @picture = Content.find(params[:id])
    send_data(@picture.data,
    :filename => @picture.name,
    :types => @picture.content_type,
    :disposition => "inline" )
  end

  def search
  end

end
