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
  # Create a new session
  def create
    user = Person.authenticate(params[:session2][:name],
                             params[:session2][:password])
       
    if user.nil?
      # Create an error message and re-render the signin form.
      redirect_to :controller => 'sessions', :action => 'new', :notice => 'Invalid authentication'
    else
      # Sign the user in and redirect to the user's show page.
      session[:user_id] = user.pid
      redirect_to :controller => 'submit', :action => 'show_etds_by_author'
    end
  end

  # Destroy session
  def destroy
    session[:user_id] = nil
    redirect_to :controller=>'sessions', :action=>'new', :notice => 'Logged out'
    reset_session
  end
end
