class ApplicationController < ActionController::Base

  include Pagy::Backend

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :middle_name, :phone, :country, :terms_of_service, :email, :type, :password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :middle_name, :phone, :country, :terms_of_service, :email, :password, :type, :current_password) }
    devise_parameter_sanitizer.permit(:accept_invitation) { |u| u.permit(:first_name, :last_name, :middle_name, :phone, :country, :terms_of_service, :invitation_token, :email, :password, :type, :current_password, :password_confirmation) }
    devise_parameter_sanitizer.permit(:invite) { |u| u.permit(:first_name, :last_name, :middle_name, :phone, :country, :terms_of_service, :invitation_token, :email, :password, :type, :current_password, :password_confirmation) }
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_locations_path
    elsif resource.user?
      camps_path
     end
  end
end
