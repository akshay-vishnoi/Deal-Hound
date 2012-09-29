class LineItemsController < ApplicationController
  
  before_filter { |controller| controller.authorize(session[:admin]) }

  def new
    redirect_to request.referrer, notice: params
  end

  def create
    begin
      @cart = Cart.find_or_create_by_user_id(session[:user_id])
    rescue
      logger.error "Attempt to access invalid cart #{params[:id]}"
      flash[:error] = "Invalid cart"
      redirect_to commodities_url
    else
      @line_item, flash[:item] = @cart.add_item(params[:p_and_s], params[:quantity].to_i)
      if @line_item.save
        redirect_to cart_path(@cart)
      else
        flash[:error] = "The current item is not available, #{params}"
        redirect_to commodities_url
      end
    end
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    flash[:item_info] = "#{@line_item.quantity} #{@line_item.p_and_s.commodity.title} had been deleted from your cart.0"
    @line_item.destroy
    respond_to do |format|
      format.js
    end
  end
end
