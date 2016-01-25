class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to documents_path, :alert => "You are not authorized to access that resource."
  end

  protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :role) }
    end

=begin
  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
  	if current_user
  		true
  	else
  		redirect_to new_session_path
  	end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
=end

end