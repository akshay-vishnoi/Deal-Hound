class ApplicationController < ActionController::Base

  protect_from_forgery

  def authorize(role)
    user = User.find_by_id(session[:user_id])
    if (user && (user.admin === role)) || (session[:admin] === true)
      return true
    elsif user && (user.id === role)
      return true
    else
      flash[:error] = "You are not authorized to access" 
      redirect_to login_url
    end
  end
  
  private
  
  def current_cart
    begin
      Cart.find_by_id(session[:cart_id])
    rescue  ActiveRecord::RecordNotFound
      flash[:error] = "Invalid cart option"
      redirect_to login_url
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end

  def create_session(user)
    session[:user_id] = user.id
    session[:admin] = user.admin    
  end
end