#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-15-2011
#########################################################
class ReviewController < ApplicationController
 # Show all etds in the submitted queue 
  def index_etd
    @etds = Etd.all
    respond_to do |format|
      format.html #=new.html.erb
      format.xml { render :xml => @etds}
    end
  end

#GET /review/new
#GET /review/new.xml
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

  # GET /review/show_etds_by_author
  def show_etds_by_author
    @author = Person.find(:first, :conditions => "pid='#{params[:pid]}'")
    @etdss = Etd.find(@author.etd_ids) unless @author.etd_ids.empty?

    respond_to do |format|
      format.html # show_etd_by_author.html.erb
      format.xml  { render :xml => @etd , :xml => @person }
    end
  end

  def show_etd
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @etd , :xml => @person }
    end
  end

  # GET /review/1/edit_etd
  def edit_etd
    @etd = Etd.find(params[:id])
    @author = @etd.people.find(:first, :conditions => "role='author'") unless @etd.people.empty?
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

  def add_files
    @picture = Content.new
    @etd = Etd.find(params[:id])
  end

  def save_files
    @picture = Content.new(params[:content])
    if @picture.save
      redirect_to(:action => 'show_files' , :id => @picture.etd_id)
    else
      render(:action => :add_files)
    end
  end

  def show_files 
    @etd = Etd.find(params[:id])
    @contents = Content.find(@etd.content_ids) unless @etd.contents.empty?
  end

  def content
    @picture = Content.find(params[:id])
    send_data(@picture.data,
    :filename => @picture.name,
    :types => @picture.content_type,
    :disposition => "inline" )
  end

  def approve
    etd = Etd.find(params[:id])
    @person = etd.people.find(:first, :conditions => "role='author'") unless etd.people.empty?
    sendemail(@person)
#    redirect_to(:actoin => :approve)
  end

  def sendemail(person)
    ApprovalMailer.deliver_confirm(person)
  end

end
