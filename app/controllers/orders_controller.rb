class OrdersController < ApplicationController
	include ChessStoreHelpers::Cart
	include ChessStoreHelpers::Shipping

	before_action :set_order, only: [:show, :destroy]
	before_action :check_login, only: [:new, :create]

	def index 
		if current_user.role?(:customer)
			@orders = Order.all.order(id: :desc).where(user_id: current_user.id).to_a
			@open_orders = Order.not_shipped.where(user_id: current_user.id).chronological.to_a

		
		else 
			@orders = Order.all.order(id: :desc).to_a
			@open_orders = Order.not_shipped.where(user_id: current_user.id).chronological.to_a
		
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
		@order = Order.new
		# Dropdown stuff
		# If school_is supplied and legit
		if params[:order][:school_id]
			@order.school_id = params[:order][:school_id]

		# Otherwise, school is not supplied, so you make a new one.
		else 
			@school = School.new(name: params[:order][:school_name], street_1: params[:order][:school_street_1], street_2: params[:order][:school_street_2], city: params[:order][:school_city], state: params[:order][:school_state], zip: params[:order][:school_zip], min_grade: params[:order][:school_min_grade], max_grade: params[:order][:school_max_grade])
			if @school.save!
				@order.school_id = @school.id
			else 
				flash[:error] = "This school could not be created."
				return render 'new'
			end
		end

		@order = Order.new(school_id: params[:order][:school_id], user_id: current_user.id, credit_card_number: params[:order][:credit_card_number], expiration_year: params[:order][:expiration_year].to_i, expiration_month: params[:order][:expiration_month].to_i) 

		# Do grandtotal, shiping and payment receipt 
		@subtotal = calculate_cart_items_cost
		@order.grand_total = calculate_cart_shipping + @subtotal


		if @order.save!
			# Pay for the order
			@order.pay

			# Save each item in the cart 
			save_each_item_in_cart(@order)
			clear_cart
			return redirect_to orders_path, notice: "Successfully created order" 
		else 
			flash[:error] = "This order could not be created."
			return render 'new'
		end

	end

	def update

	end

	def add_to_cart
		add_item_to_cart(params[:item_id])
		redirect_to(:back)
	end

	def remove_from_cart
		remove_item_from_cart(params[:item_id])
		redirect_to(:back)
	end

	def destroy 
		if @order.destroy
			redirect_to orders_path, notice: "Successfully removed Order No. #{@order.id} from the system."
		else 
			redirect_to orders_path, notice: "Failed to remove Order No. #{@order.id} from the system. Some items have been shipped."
		end
	end

private 

	def set_order
      @order = Order.find(params[:id])
    end

	def order_params
		params.require(:order).permit(:school_id, :user_id, :school_name, :school_street_1, :school_street_2, :school_city, :school_state, :school_zip, :school_min_grade, :school_max_grade)
	end

end
