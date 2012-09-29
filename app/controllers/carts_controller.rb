class CartsController < ApplicationController

  before_filter { |conroller| conroller.authorize(session[:admin]) }
  
  def show
      @cart = Cart.find_by_id(params[:id])
    if @cart
      flash[:error] = "Invalid cart option"
      redirect_to login_url
    else
      respond_to do |format|
        flash[:cart_flash] = true
        flash[:item_info] = flash[:item]
        format.html { redirect_to request.referrer }
      end
    end    
  end
end
