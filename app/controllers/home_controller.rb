class HomeController < ApplicationController

	def home
		if logged_in?
			@items_to_reorder = Item.need_reorder.alphabetical.to_a
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
  	end

	def clocks
		@items = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
		@category = 'Clocks'
	end

	def pieces 
		@items = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
		@category = 'Pieces'
	end

	def supplies
		@items = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10)
		@category = 'Supplies'
	end

  
end