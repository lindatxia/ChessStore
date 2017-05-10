class SessionsController < ApplicationController
  include ChessStoreHelpers::Cart

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && User.authenticate(params[:email], params[:password])

      # FIRST THING, create a cart whenever the user logs in
      create_cart
      session[:user_id] = user.id
  
      redirect_to home_path, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil

    # We also need to destroy a cart after we log out
    destroy_cart
    
    redirect_to home_path, notice: "Logged out!"
  end

end