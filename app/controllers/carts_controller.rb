class CartsController < ApplicationController

  before_filter { |conroller| conroller.authorize(session[:admin]) }
  
  def show
      @cart = Cart.find_by_id(params[:id])
    if @cart
      respond_to do |format|
        flash[:cart_flash] = true
        flash[:item_info] = flash[:item]
        format.html { redirect_to request.referrer }
      end
    else      
      flash[:error] = "Invalid cart option"
      redirect_to login_url
    end    
  end
end
