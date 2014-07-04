class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_time_zone_and_last_activity
  before_filter :check_force_chat

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me, :gender, :time_zone, :country) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def set_time_zone_and_last_activity
    if user_signed_in?
      Time.zone = current_user.time_zone if current_user.time_zone
      current_user.update_column(:last_activity, Time.now)
    end
  end

  def check_force_chat
    if user_signed_in? && current_user.force_chat?
      redirect_to chats_path, alert: "You are being forced to chat." unless controller_name == "chats"
    end
  end
end
