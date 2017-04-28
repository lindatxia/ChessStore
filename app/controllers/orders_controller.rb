class OrdersController < ApplicationController
	include ChessStoreHelpers::Cart
	
	def index 
		if current_user.role?(:customer)
			@orders = current_user.orders.chronological.to_a
		else 
			@orders = Order.chronological.to_a
		end
	end

	def new 
		@order = Order.new
	end

	def edit
	end

	def create

	end

	def destroy 
		@order.destroy

	end

	private 

	def order_params
		params.require(:order).permit(:date, :school_id, :user_id, :grand_total, :payment_receipt)
	end
end
