class OrdersController < ApplicationController
	include ChessStoreHelpers::Cart

	before_action :set_user, only: [:show, :destroy]
	before_action :check_login, only: [:new, :create]

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

	def show
	end

	def edit
	end

	def create
		@order = Order.new(order_params)
		if @order.save 
			redirect_to orders_path(@order), notice: "Successfully created"
		end
	end

	def update
	end

	def add_to_cart
		add_item_to_cart(params[:item_id])
		redirect_to orders_path
	end

	def remove_from_cart
		remove_item_from_cart(params[:item_id])
		redirect_to orders_path
	end

	def destroy 
		@order.destroy
		redirect_to orders_path, notice: "Successfully removed #{@order.id} from the system."
	end

	private 

	def set_order
      @order = User.find(params[:id])
    end

	def order_params
		params.require(:order).permit(:date, :school_id, :user_id, :grand_total, :payment_receipt)
	end
end
