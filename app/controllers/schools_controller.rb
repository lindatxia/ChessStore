class SchoolsController < ApplicationController
	before_action :check_login
	authorize_resource

	def index 
		@active_schools = School.all.active.alphabetical.to_a
		@inactive_schools = School.all.inactive.alphabetical.to_a
	end

	def new 

	end

end
