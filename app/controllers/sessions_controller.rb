#########################################################
# The source codes are developed by
# Digital Library and Archive at Virginia Tech. 
# Last updated: Feb-16-2011
#########################################################
class SessionsController < ApplicationController
#  ssl_required :new

  def new
    @title = "Log in"
  end
  # Notify an invalid authentication
  def loginfailure

  end

  # Create a new session
  def create
    #
    # Authentication
    # user is a type of Person
    @person = Person.authenticate(params[:session2][:name],
                             params[:session2][:password])
    respond_to do |format|
       
      if @person.nil?
      # Create an error message and re-render the signin form.
        #format.html {redirect_to(:controller => 'submit', :action => 'login', :notice => 'Invalid authentication')}
        format.html {redirect_to(:controller => 'sessions', :action => 'loginfailure', :notice => 'Invalid authentication')}
      else
      # Sign the user in and redirect to the user's show page.
        session[:user_id] = @person.pid
       
      # Authorization
      # Before letting a user landing on the user page, we need to check authorization
        if @person.authorize.nil? 
          @person.save!
          #format.html {redirect_to(:controller => 'submit', :action => 'new_etd',:author_id=>@user.pid)}
        else
          #format.html {redirect_to(:controller => 'submit', :action => 'show_etds_by_author')}
          format.html {redirect_to(:controller => 'sessions', :action => 'authorize')}
        end # if
      end #if
    end #respond
  end # def create

  # Destroy session
  def destroy
    session[:user_id] = nil
    redirect_to :controller=>'sessions', :action=>'new', :notice => 'Logged out'
    reset_session
  end

  def authorize
    @person=Person.find(:first,:conditions=>"pid='#{session[:user_id]}'")
    @roles=@person.roles

    @array_roles = []
    for role  in @roles
      @array_roles << role.name
    end
  end
  def authorizationfailure

  end

  def authorize2
    #@person=Person.find(:first,:conditions=>"pid='#{session[:user_id]}'")
    @person = Person.authenticate(params[:session][:name],
                             params[:session][:password])
    if !@person.nil? 
      @roles=@person.roles

      @array_roles = []
      for role  in @roles
        @array_roles << role.name
      end
    end

    respond_to do |format|
      if @person.nil?
      # Create an error message and re-render the signin form.
        format.html {redirect_to(:controller => 'sessions', :action => 'authorizationfailure', :notice => 'Invalid authorization')}
      else
      # Sign the user in and redirect to the user's show page.
        session[:user_id] = @person.pid

      # Authorization
      # Before letting a user landing on the user page, we need to check authorization
      end #if

      format.html {redirect_to(:controller=>:admin, :action=>:admin_main)}
    end
  end


end


