class SchoolsController < ApplicationController
	before_action :check_login, except: [:new, :create]
	authorize_resource

	def index 
		@active_schools = School.all.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@inactive_schools = School.all.inactive.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def new 
		@school = School.new
	end

	def create 
		@school = School.new(school_params)
		if @school.save 
			flash[:notice] = "Successfully saved #{@school.name}!"
			redirect_to schools_path
		else 
			render action: 'new'
		end
	end


	private 

	def school_params 
		params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :active)
	end

end
