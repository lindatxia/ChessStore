class UsersController < ApplicationController

	# What does this set_user thing do?
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :check_login, only: [:new, :create]

	def index
		@users = User.alphabetical.paginate(:page => params[:page]).per_page(7)
	end

	def show 
	end

	def new 
		@user = User.new
	end

	def edit 
		# @user = User.current_user
	end

	def create 
		@user = User.new(user_params)
		if @user.save
			redirect_to(@user, :notice => 'User was successfully created.')
		else
			flash[:error] = "This user could not be created."
			render :action => "new"
		end
	end

	def update
		if @user.update_attributes(user_params)
			redirect_to(@user, :notice => 'User was successfully updated.')
		else
			render :action => "edit"
		end
	end


	private

	def set_user
      @user = User.find(params[:id])
    end

	def user_params
		if current_user && current_user.role?(:admin)
			params.require(:user).permit(:first_name, :last_name, :username, :email, :picture, :phone, :password, :password_confirmation, :role, :active)  
		else
			params.require(:user).permit(:first_name, :last_name, :username, :email, :picture, :phone, :password, :password_confirmation, :active)
		end
	end

end