class ApplicationController < ActionController::Base

  protect_from_forgery

  def subscription
    @subscribe = Subscribe.new(:email => params[:email])
    if @subscribe.save
      flash[:notice] = "#{params[:email]} has been subscribed."
    else
      flash[:subscription] = @subscribe.errors.get(:email).first
    end
    redirect_to request.referrer
  end

  def unsubscribe
    @subscribe = Subscribe.find_by_email(params[:email])
    if @subscribe
      @subscribe.delete 
      flash[:notice] = "Successfully unsubscribed."
    else
      flash[:error] = "Invalid Request"
    end
    redirect_to commodities_url
  end

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

  def category_list
    Category.select('name').collect { |cat| cat.name }
  end
end