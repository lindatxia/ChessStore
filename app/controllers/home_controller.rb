class HomeController < ApplicationController

	def home
		if logged_in?
			@items_to_reorder = Item.need_reorder.alphabetical.to_a
			@orders = Order.all.not_shipped.chronological.to_a
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

	def remove_from_shipping_list
		OrderItem.where(id: params[:oi_id]).first.shipped
		@orders = Order.all.not_shipped.chronological.to_a
		# redirect_to home_path
	end

  
end