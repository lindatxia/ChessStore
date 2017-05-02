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
		# @order.school.build
	end

	def show
	end

	def edit
	end

	def create
		# if params[:school_id] then @order.school_id = params[:school_id]
		# else
		# @school = School.new(PARAMETERS WE WROTE BELOW)
		# if @school.save
			#@order.school_id = @school.id
			#@ 
		# Else 

		

		@order = Order.new(order_params)

		if @order.save 
			redirect_to order_path(@order), notice: "Successfully created order" 
		else 
			flash[:error] = "This order could not be created."
			render 'new'
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
      @order = Order.find(params[:id])
    end

	def order_params
		params.require(:order).permit(:date, :school_id, :user_id, school_attributes: [:id, :name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade, :_destroy])
	end

	# def order_params
	# params.require(:order).permit(:date, :school_id, :user_id, :school_name, :school_zip, :school_street1, :school_street2, :school_city, :school_state)
	# end



end
