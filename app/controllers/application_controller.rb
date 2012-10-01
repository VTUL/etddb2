class ApplicationController < ActionController::Base
  before_filter :store_location
  before_filter :authenticate_person!
  protect_from_forgery

  private
  # Allow login to redirect back from anywhere.
  def store_location
    session[:previous_urls] ||= []
    # store unique urls only
    session[:previous_urls].prepend request.fullpath if session[:previous_urls].first != request.fullpath
    session[:previous_urls].pop if session[:previous_urls].count > 2
  end

  # Overwriting the login redirect.
  def after_sign_in_path_for(resource_or_scope)
    session[:previous_urls].last || root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    etds_path
  end
end
