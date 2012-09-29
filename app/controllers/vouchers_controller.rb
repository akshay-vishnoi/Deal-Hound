class VouchersController < ApplicationController
  def index
  end

  def new
    @voucher = Voucher.new
  end

  def create
    @commodity = Commodity.find_by_title(params[:voucher]["commodity"])
    params[:voucher].delete "commodity"
    @voucher = Voucher.new(params[:voucher])
    @voucher.commodity = @commodity
    if @voucher.save
      redirect_to commodities_url
    else
      render :new
    end
  end

  def edit
    @voucher = Voucher.find(params[:id])
  end

  def update
    @commodity = Commodity.find_by_title(params[:voucher]["commodity"])
    params[:voucher].delete "commodity"
    @voucher = Voucher.find(params[:id])
    @voucher.commodity = @commodity
    if @voucher.update_attributes(params[:voucher])
      redirect_to commodities_url
    else
      render :edit
    end
  end
end
