class ApplicationController < ActionController::Base

  protect_from_forgery

  def authorize(role)
    user = User.find_by_id(session[:user_id])
    if (user && (user.admin == role)) || (session[:admin] == 1)
      true
    else
      redirect_to login_url, notice: 'Please log in as a User'
    end
  end
  
  private
    def current_cart
      Cart.find(session[:cart_id])
    rescue  ActiveRecord::RecordNotFound

      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
end