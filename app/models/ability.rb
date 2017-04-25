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

			# Can create, edit and read employee data.
			can :create, User do |u|
				!u.role?(:admin)
			end

			can :read, User do |u|
				!u.role?(:admin)
			end

			can :update, User do |u|
				!u.role?(:admin)
			end

			# Can create, read and update items in the system.
			can :create, Item 
			can :read, Item
			can :update, Item

			# 4. Can read full price history for a particular item.
			can :read, ItemPrice

			# 4. Can create new prices for a particular item.
			can :create, ItemPrice

			# 5. Can adjust the inventory levels for an item by adding purchases to the system.
			can :create, Purchase
			# can [:purchase], Item

			# 7. Can read information about customers, schools and orders in the system

			can :read, User do |u|
				u.role?(:customer)
			end

			can :read, School

			can :read, Order

		end

	end

end
