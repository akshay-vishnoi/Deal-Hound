class LineItemsController < ApplicationController
  
  before_filter { |conroller| conroller.authorize(session[:admin]) }

  def new

    redirect_to request.referrer, notice: params
  end

  def index
  end

  def create
    @cart = Cart.find_or_create_by_user_id(session[:user_id])
    @commodity_sku = CommoditySku.find(params[:commodity_sku_id])
    @line_item = @cart.add_item(@commodity_sku.id, @commodity_sku.commodity.selling_price, params[:quantity])
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
    @line_item.destroy
    respond_to do |format|
      format.js
    end
  end
end
