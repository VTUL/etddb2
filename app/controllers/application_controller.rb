class ApplicationController < ActionController::Base
#  before_filter :authenticate_person! #:except = {:etds=>:index, :etds=>:show}

  protect_from_forgery

  # define ability
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    #Rails.logger.access "Access denied on #{exception.action} #{exception.subject.inspect}"
    #Rails.logger.provenance "Access denied on #{exception.action} #{exception.subject.inspect}"
  end

  private

  # Overwriting the login redirect.
  def after_sign_in_path_for(resource_or_scope)
    etds_path
  end

end
