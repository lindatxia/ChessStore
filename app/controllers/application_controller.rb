class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ChessStoreHelpers::Cart
  include ChessStoreHelpers::Shipping

  protect_from_forgery with: :exception

  # Automaticaly evaluated before any item in the controller is executed
  before_action :count_items_in_cart

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Nice try. Do or do not. There is no try."
    redirect_to home_path
  end

  # handle missing pages the BSG way...
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render template: 'errors/not_found'
  end

  private

  def count_items_in_cart
    # The cart needs to exist first (when you log in, a cart is created)
    # This method is always running, so consider the exception when a guest customer is browsing the site.
    
    unless session[:cart].nil?
      @cart = get_list_of_items_in_cart
      @cart_subtotal = calculate_cart_items_cost
      @shipping = calculate_cart_shipping
      @cart_grandtotal = @shipping + @cart_subtotal
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Helper methods make this method available to the views
  helper_method :current_user

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def check_login
    redirect_to login_url, alert: "You need to log in to view this page." if current_user.nil?
  end
  
 
end
