class CartsController < ApplicationController

  before_filter { |conroller| conroller.authorize(session[:admin]) }
  
  def show
    begin
      @cart = Cart.find_by_id(params[:id])
    rescue ActiveRecord::RecordNotFound
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
