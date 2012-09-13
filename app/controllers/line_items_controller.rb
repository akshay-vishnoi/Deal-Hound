class LineItemsController < ApplicationController
  
  before_filter { |conroller| conroller.authorize(session[:admin]) }

  def new

    redirect_to request.referrer, notice: params
  end

  def index
  end

  def create
    @cart = Cart.find_or_create_by_user_id(session[:user_id])
    @line_item, flash[:item] = @cart.add_item(params[:commodity_sku_id], params[:quantity].to_i)
    if @line_item.save
      redirect_to cart_path(@cart)
    else
      flash[:error] = "The current item is not available"
      redirect_to commodities.url
    end
  end

  def update
  end

  def destroy
    @line_item = LineItem.find(params[:id])
    flash[:item_info] = "#{@line_item.commodity_sku.quantity} #{@line_item.commodity_sku.commodity.title} had been deleted from your cart.0"
    @line_item.destroy
    respond_to do |format|
      format.js
    end
  end
end
