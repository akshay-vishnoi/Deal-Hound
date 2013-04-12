class ApplicationController < ActionController::Base
  has_mobile_fu(true)
  # before_filter :hee
  protect_from_forgery

  def hee
    debugger
    puts "hlo"
  end
  def authorize(role)
    puts "in authorize"
    user = User.find_by_id(session[:user_id])
    if (user && (user.admin === role)) || (session[:admin] === true)
      return true
    elsif user && (user.id === role)
      return true
    else
      flash[:error] = "You are not authorized to access" 
      redirect_to login_url
    end
    puts "out authorize"

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

  def category_list
    Category.select('name').collect { |cat| cat.name }
  end
end