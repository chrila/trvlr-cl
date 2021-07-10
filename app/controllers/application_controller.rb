# frozen_string_literal: true

class ApplicationController < ActionController::Base
  check_authorization unless: :devise_or_active_admin?

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied on #{exception.action} #{exception.subject.inspect}"
    respond_to do |format|
      format.json { head :forbidden, content_type: "text/html" }
      format.html { redirect_to root_path, alert: exception.message }
      format.js   { head :forbidden, content_type: "text/html" }
    end
  end

  protected
    def devise_or_active_admin?
      devise_controller? || active_admin_resource?
    end

    def active_admin_resource?
      self.class.ancestors.include?(ActiveAdmin::BaseController) ||
        self.class.ancestors.include?(ActiveAdmin::Devise::SessionsController)
    end
end
