class SchoolsController < ApplicationController
	before_action :check_login, except: [:new, :create]
	authorize_resource

	def index 
		@active_schools = School.all.active.alphabetical.to_a
		@inactive_schools = School.all.inactive.alphabetical.to_a
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
