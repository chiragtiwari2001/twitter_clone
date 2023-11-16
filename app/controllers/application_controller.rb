class ApplicationController < ActionController::Base
  include ApplicationHelper

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifications, if: :current_user

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :email, :password)}

      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:username, :email, :password, :current_password, :avatar, :profile_background)}
    end

    def authenticate_admin!
      if user_signed_in?
        unless admin?
          flash[:danger] = "you are not authorized to access this page!"
          redirect_to root_path
        end
      else
        flash[:warning] = "You must sign in first!"
        redirect_to new_user_session_path
      end
    end

    def set_notifications
      @notifications = Notification.where(recipient: current_user).newest_first
      .limit(9)
      @unread = @notifications.unread
      @read = @notifications.read
    end

    def set_previous_url
      session[:previous_url] = request.referer
    end
end
