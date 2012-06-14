class ApplicationController < ActionController::Base
#  before_filter :authenticate_person! #:except = {:etds=>:index, :etds=>:show}
  protect_from_forgery

  private

  # Overwriting the login redirect.
  def after_sign_in_path_for(resource_or_scope)
    location = session[:return_to]
    session[:return_to] = nil
    (location.nil?) ? person_path(current_person) : location.to_s
  end
end
