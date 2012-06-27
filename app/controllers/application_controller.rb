class ApplicationController < ActionController::Base
  before_filter :authenticate_person!
  protect_from_forgery

  private

  # Overwriting the login redirect.
  def after_sign_in_path_for(resource_or_scope)
    person_path(current_person)
  end
end
