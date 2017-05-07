class HomeController < ApplicationController

	def home
		if logged_in?
			@reorder_items = Item.need_reorder.alphabetical.to_a
			@orders = Order.all.not_shipped.chronological.to_a
			@recent_orders = Order.all.chronological.first(5).to_a

			@items = Item.all.alphabetical.to_a
			@item_names = Array.new
			@quantity = Array.new

			@items.map do |i| 
				sum = 0
				i.order_items.each do |oi|
					sum += oi.quantity
				end
				@quantity << sum
			end

			@items.map do |i| 
				@item_names << i.name
			end


		end
	end

	def about
	end

	def contact
	end

	def privacy
	end

  	def boards
  		@items = Item.active.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
  		@category = 'Boards'
  		@inactive_items = Item.inactive.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
  	end

	def clocks
		@items = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
		@category = 'Clocks'
		@inactive_items = Item.inactive.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def pieces 
		@items = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
		@category = 'Pieces'
		@inactive_items = Item.inactive.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def supplies
		@items = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10)
		@category = 'Supplies'
		@inactive_items = Item.inactive.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	# For shippers to easily remove items they've shipped via AJAX.
	def remove_from_shipping_list
		OrderItem.where(id: params[:oi_id]).first.shipped
		@orders = Order.all.not_shipped.chronological.to_a
		# redirect_to home_path
	end

	# For managers to easily remove items they've reordered via AJAX.
	def remove_from_reorder_list
		Item.where(id: params[:i_id]).first
		@reorder_items = Item.all.need_reorder.alphabetical.to_a
	end
  
end