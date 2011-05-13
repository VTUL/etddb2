class ApplicationController < ActionController::Base
  protect_from_forgery

  # define ability
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    #Rails.logger.access "Access denied on #{exception.action} #{exception.subject.inspect}"
    #Rails.logger.provenance "Access denied on #{exception.action} #{exception.subject.inspect}"
  # ...
  end

end
