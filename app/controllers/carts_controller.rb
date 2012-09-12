class CartsController < ApplicationController

  before_filter { |conroller| conroller.authorize(session[:admin]) }
  
  def show
    begin
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_url, notice: "Invalid cart option"
    else
      respond_to do |format|
        format.html
      end
    end    
  end
end
