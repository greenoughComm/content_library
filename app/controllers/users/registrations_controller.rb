class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :check_permissions, :only => [:new, :create, :cancel]
  before_action :authenticate_user!
  skip_before_filter :require_no_authentication
 
  def check_permissions
    authorize! :create, resource
  end

  def edit
  	@users = User.all
  	authorize! :edit, @users
  end

  def new
    @users = User.all
    authorize! :create, @users
    super
  end
  
end