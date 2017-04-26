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
  
end