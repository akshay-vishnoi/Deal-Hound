class DealsController < ApplicationController
  def index
  end

  def show_commodities
    @products = CommoditySku.all
    @vouchers = Voucher.all
  end

  def new
    if params[:voucher] === "1"
      @commodity = Voucher.find(params[:vouchers])
    else params[:voucher] === "0"
      @commodity = CommoditySku.find(params[:products])
    end
    @deal = Deal.new
    @deal.p_and_s = @commodity
    flash.now[:notice] = "You have selected #{@deal.p_and_s.commodity.title}."
  end

  def create
    @deal = Deal.new(params[:deal])
    @deal.remaining_quantity = @deal.max_quantity
    if @deal.save
      redirect_to show_commodities_deals_url, notice: "Deal created successfully."
    else
      render :new
    end
  end

  def index
    @deals = Deal.all
  end

  def show
    @deal = Deal.find_by_id(params[:id])
    redirect_to deals_path if @deal.nil?
  end

  def edit
    @deal = Deal.find(params[:id])
  end

  def destroy
    @deal = Deal.find(params[:id])
    @deal.destroy
    redirect_to deals_path
  end

  def update
    @deal = Deal.find(params[:id])
    params[:deal][:max_quantity] = @deal.max_quantity + params[:deal][:remaining_quantity].to_i - @deal.remaining_quantity
    if @deal.update_attributes(params[:deal])
      redirect_to deals_url, notice: "Deal updated successfully."
    else
      render :edit
    end
  end
end
