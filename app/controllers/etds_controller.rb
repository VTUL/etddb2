class EtdsController < ApplicationController
  skip_before_filter :authenticate_person

  # GET /etds
  # GET /etds.xml
  def index
    @etds = Etd.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @etds }
    end
  end

  # GET /etds/1
  # GET /etds/1.xml
  def show
    @etd = Etd.find(params[:id])
    @prs = []
    for pr in @etd.people_roles do
      p = Person.find(pr.person_id)
      @prs << {:first_name => p.first_name.to_s, :last_name => p.last_name.to_s, :role => Role.find(pr.role_id).name}
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @etd }
    end
  end

  # GET /etds/new
  # GET /etds/new.xml
  def new
    respond_to do |format|
      # This should be implemented as a before_filter.
      if !person_signed_in?
        format.html { redirect_to(login_path, :notice => "You must login create an ETD.") }
      end

      @etd = Etd.new
      #Get current user from Devise.
      @author = current_person

      format.html # new.html.erb
      format.xml  { render :xml => @etd }
    end
  end

  # GET /etds/1/edit
  def edit
    respond_to do |format|
      @etd = Etd.find(params[:id])
      # Again, this should be implemented in a before_filter
      if person_signed_in?
        # This works, but is only a hack, we should use Cancan.
        if !current_person.etds.include?(@etd)
          format.html { redirect_to(etds_path, :notice => "You cannot edit that ETD.") }
        else
          format.html { render :action => "edit" }
        end
      else
        format.html { redirect_to(login_path, :notice => "You must sign in to edit ETDs.") }
      end
    end
  end

  # POST /etds
  # POST /etds.xml
  def create
    @etd = Etd.new(params[:etd])

    pr = PeopleRole.new
    pr.person_id = current_person.id
    pr.role_id = Role.find(:first, :conditions => "name = 'Author'")
    @etd.people_roles << pr

    respond_to do |format|
      if @etd.save
        format.html { redirect_to(@etd, :notice => 'Etd was successfully created.') }
        format.xml  { render :xml => @etd, :status => :created, :location => @etd }
      else
        format.html { render :action => "new", :notice => 'You have errors.' }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /etds/1
  # PUT /etds/1.xml
  def update
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.update_attributes(params[:etd])
        format.html { redirect_to(@etd, :notice => 'Etd was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @etd.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /etds/1
  # DELETE /etds/1.xml
  def destroy
    @etd = Etd.find(params[:id])

    respond_to do |format|
      # before_filter
      if !person_signed_in?
        format.html { redirect_to etds_path, :notice => "You must log in to delete your ETDs." }
      else
        # Cancan
        if current_person.etds.include?(@etd)
          for pr in @etd.people_roles do
            pr.destroy
          end
          for content in @etd.contents do
            content.destroy
          end
          @etd.destroy
          format.html { redirect_to :action => 'index', :notice => "ETD Deleted." }
          format.xml  { head :ok }
        else
          format.html { redirect_to etds_path, :notice => "You cannot delete that ETD."}
        end
      end
    end
  end

  # GET /etds/my_etds
  def my_etds
    respond_to do |format|
      # This should be implemented in a before_filter
      if person_signed_in?
        # This does not work. Need to get Etds from PeopleRoles table, but nothing is being stored there.
        @authors_etds = current_person.etds

        format.html # my_etds.html.erb
        format.xml  { render :xml => @authors_etds }
      else
        format.html {redirect_to(login_path, :notice => "You need to login to browse your ETDs.")}
      end
    end
  end

  # GET /etds/change_availability
  def change_availability
#    if person_signed_in?
#      @authors_etds = current_person.etds
      @etd= Etd.find(params[:id])

#      format.html # show_etd_by_author.html.erb
#      format.xml  { render :xml => @etd , :xml => @person }
#    else
#      format.html {redirect_to(login_path, :notice => "You need to login to browse your ETDs.")}
#    end
  end

  # GET /etds/new_next/1
  def next_new
    # Assuming someone is signed in, and authorized, as this should only be accessable from /etd/new
    @etd = Etd.find(params[:id])
    @prs = []
    for pr in @etd.people_roles do
      p = Person.find(pr.person_id)
      @prs << {:first_name => p.first_name.to_s, :last_name => p.last_name.to_s, :role => Role.find(pr.role_id).name}
    end
    respond_to do |format|
      format.html # new_next.html.erb
    end
  end
end
