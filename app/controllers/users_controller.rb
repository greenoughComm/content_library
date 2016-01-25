class UsersController < ApplicationController
	before_action :authenticate_user!


	def index
		@users = User.all
		authorize! :index, @users
	end

	def edit
		@user = User.find(4)
		authorize! :edit, @user
	end

	def update
    	@user = User.find(params[:id])
    	params[:user].delete(:password) if params[:user][:password].blank?
    	params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    	if @user.update_attributes(params[:user])
      		flash[:notice] = "Successfully Updated User."
      		render :action => 'index'
    	else
      		render :action => 'edit'
    	end
  	end

	def create
		@user = User.new(user_params)
		
		if @user.save
			@users = Document.all
			flash[:notice] = "User Successfully Created."
			render action: "index"
		else
			render action: "new"
		end
	end


	def destroy
	    @user = User.find(params[:id])
	    if @user.destroy
	    	flash[:notice] = "Successfully Deleted User."
	    	redirect_to root_path
	    end
	end 

private
	def user_params
		params.require(:user).permit(:email, :first_name, :last_name, :department, :password, :password_confirmation, :role)
	end

end