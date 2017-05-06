class UsersController < ApplicationController

	# What does this set_user thing do?
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :check_login, except: [:new, :create]
	authorize_resource

	def index
		@users = User.all.alphabetical.paginate(:page => params[:page]).per_page(7)
		@employees = User.all.alphabetical.employees
		@customers = User.all.alphabetical.customers
	end

	def show 
	end

	def new 
		@user = User.new
	end

	def edit 
	end

	def create 
		@user = User.new(user_params)
    	if @user.save
      		session[:user_id] = @user.id
      		redirect_to home_path, notice: "Thank you for signing up!"
    	else
	      flash[:error] = "This user could not be created."
	      render "new"
    	end
	end

	def update
		if @user.update_attributes(user_params)
			flash[:notice] = "#{@user.proper_name} is updated."
			redirect_to @user
		else
			render :action => 'edit'
		end
	end

	def destroy 
		@user.destroy
    	flash[:notice] = "Successfully deleted #{@user.proper_name} from A&M Chess Store."
    	redirect_to users_url
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