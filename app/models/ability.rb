class Ability 

	include CanCan::Ability 

	def initialize(user)
		# Set user to new Uesr if not logged in
		user ||= User.new

		if user.role? :admin
		end

		


	end


end
