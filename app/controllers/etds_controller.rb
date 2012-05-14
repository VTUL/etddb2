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
      @prs << {:first_name => p.first_name.to_s, :last_name => p.last_name.to_s, :role => Role.find(pr.role_id).name, :pr => pr}
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

    @etd.urn = Time.now().strftime("etd-%Y%m%d-%H%M%S%2L")
    @etd.url = "http://scholar.lib.vt.edu/theses/submitted/#{@etd.urn}/"

    pr = PeopleRole.new
    pr.person_id = current_person.id
    pr.role_id = Role.find(:first, :conditions => "name = 'Author'").id
    @etd.people_roles << pr

    @etd.cdate = Time.now()
    @etd.status = "Created"

    d = [params[:etd][:department_ids][:id_1]]
    if params[:etd][:department_ids][:id_2] != "" then
      d << params[:etd][:department_ids][:id_2]
    end
    @etd.department_ids = d

    respond_to do |format|
      if @etd.save
        format.html { redirect_to(next_new_etd_path(@etd), :notice => 'Etd was successfully created.') }
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

    d = [params[:etd][:department_ids][:id_1]]
    if params[:etd][:department_ids][:id_2] != "" then
      d << params[:etd][:department_ids][:id_2]
    end
    params[:etd][:department_ids] = d

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
        @authors_etds = current_person.etds

        format.html # my_etds.html.erb
        format.xml  { render :xml => @authors_etds }
      else
        format.html {redirect_to(login_path, :notice => "You need to login to browse your ETDs.")}
      end
    end
  end

  # GET /etds/next_new/1
  def next_new
    # Assuming someone is signed in, and authorized, as this should only be accessable from /etd/new
    @etd = Etd.find(params[:id])
    @prs = []
    for pr in @etd.people_roles do
      p = Person.find(pr.person_id)
      @prs << {:first_name => p.first_name.to_s, :last_name => p.last_name.to_s, :role => Role.find(pr.role_id).name, :pr => pr}
    end
    respond_to do |format|
      format.html # new_next.html.erb
    end
  end

  # PUT /etds/next_new/1
  # (This is used from next_new, and add_contents)
  def save_contents
    @etd = Etd.find(params[:id])
    if @etd.update_attributes(params[:etd])
      redirect_to params[:origin] + @etd.id.to_s, :notice => "Successfully updated article."
    else
      redirect_to params[:origin] + @etd.id.to_s
    end    
  end

  # GET /etds/add_contents/1
  def add_contents
    @etd = Etd.find(params[:id])

    respond_to do |format|
      format.html # add_contents.html.erb
    end
  end

  # GET /etd/submit/1
  def submit
    @etd = Etd.find(params[:id])
    @etd.status = "Submitted"
    @etd.sdate = Time.now()
    @etd.save()
    
    @author = Person.find(@etd.people_roles.where(:role_id => Role.where(:name => 'Author').first).first.person_id)
    EtddbMailer.confirm_submit_author(@etd, @author).deliver
    EtddbMailer.confirm_submit_school(@etd, @author).deliver
    EtddbMailer.confirm_submit_committee(@etd, @author).deliver

    respond_to do |format|
      format.html #submit.html.erb
    end
  end

  # POST /etd/vote/1
  def vote
    @etd = Etd.find(params[:id])

    respond_to do |format|
      if @etd.status == "Submitted"
        if person_signed_in?
          pr = @etd.people_roles.where(:person_id => current_person.id).first
          if !pr.nil? && Role.where("name LIKE 'Committee%'").map(&:id).include?(pr.role_id)
            if params[:vote] == 'true'
              pr.vote = true
            else
              pr.vote = false
            end
            pr.save()
            format.html #vote.html.erb
          else
            # Error. You are either not part of this ETD, or at least not on it's committee.
          end
        else
          # Error. Must be signed in.
        end
      else
        # Error. ETD not submitted. You are either too early, or too late.
      end
    end
  end
end
