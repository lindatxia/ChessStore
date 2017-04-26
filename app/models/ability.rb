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


		elsif user.role? :shipper

			# 1. Can read their own personal information in the system
			can :show, User do |u|
				u.id == user.id
			end

			# 2. Can read information related to orders that need to be shipped 
			can :read, Order

			# 3. Can read information about items
			can :read, Item

		elsif user.role? :customer

			# 1. Can read their own personal information in the system.

			can :read, User do |u| 
				u.id == user.id
			end

			# 2. Can place new orders and cancel unshipped orders (??? how to do this part ???)

			can :create, Order

			# 3. Can read info about items, but just not inventory or price history

			can :read, Item

			can :read, Order 

			can :read, OrderItem

			can :update, School

		else 

			can :read, Item

			can :create, User 

			can :create, User

		end

	


end
