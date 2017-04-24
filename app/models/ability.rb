class Ability 

	include CanCan::Ability 

	def initialize(user)
		# Set user to new User if not logged in
		user ||= User.new

		if user.role? :admin
			can :manage, :all


		elsif user.role? :manager
			# Can read anything 
			can :read, :all

			# Can read, edit, and update employee data.
			can :read, User do |u|
				!u.role?(:admin)
			end

			can :update, User do |u|
				!u.role?(:admin)
			end

			# Can read, edit and update items in the system.
			can :read, 

			end

		end

	end

end
