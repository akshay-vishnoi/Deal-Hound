class CartsController < ApplicationController

  before_filter { |conroller| conroller.authorize(session[:admin]) }
  
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to login_url, notice: "Invalid cart option"
    else
      respond_to do |format|
        flash[:cart_flash] = true
        flash[:added_item] = flash[:item]
        format.html { redirect_to request.referrer}
        format.js { render :action => :show, :layout => false}
      end
    end    
  end
end
