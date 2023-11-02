class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :avatar, :profile_background)}
    end

    def authenticate_admin!
      redirect_to root_path unless admin?
    end
end
