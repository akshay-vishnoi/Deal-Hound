class CommoditiesController < ApplicationController
  Rails.logger.info "in commodity_controller start"
  include CommodityHelper
  before_filter(:only => [:new, :create, :delete, :edit]) { |controller| controller.authorize(true) }
  Rails.logger.info "in commodity_controller after before_filter"
  
  def index
    Rails.logger.info "entering index action"
    # debugger
    @category = Category.find_by_id(params[:category_id])
    if @category
      @commodities = @category.commodities.search(params)
    elsif params[:new_launch]
      @commodities = Commodity.new_launches(params[:page])
    else
      @commodities = Commodity.search(params)
    end
    Rails.logger.info "exiting index action"
  end

  def new
    @category = Category.new
    @categories = category_list
    @commodity = Commodity.new
    @commodity.images.build
    @commodity_sku = @commodity.commodity_skus.build
  end

  def show
    @commodity = Commodity.find(params[:id])
    respond_to do |format|
      if @commodity
        format.js
        format.html
      else
        flash[:error] = "Invalid Commodity"
        format.html { redirect_to commodities_url }
      end
    end
  end

  def edit
    begin
      @commodity = Commodity.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Invalid Commodity"
      redirect_to commodities_url
    else
      @categories = category_list
      @category = Category.new
      params[:selected_category] = @commodity.category.name
      @commodity.images.build
      @commodity.commodity_skus.build
    end
  end

  def update
    @cat = Category.find_by_name(params[:commodity]["category"])
    params[:commodity].delete_if { |k,v| k == "category" }
    @commodity = Commodity.find(params[:id])
    @commodity.category = @cat
    if @commodity.update_attributes(params[:commodity])
      redirect_to commodities_url, notice: "Update successful"
    else
      @category = Category.new
      @categories = category_list
      render :edit
    end
  end

  def del_image
    Image.destroy(params[:image_id])
    redirect_to request.referrer, notice: "Image deleted"
  end
  
  def destroy
    @commodity = Commodity.find(params[:id])
    @commodity.destroy
    redirect_to commodities_path
  end
  
  def create
    @cat = Category.find_by_name(params[:commodity]["category"])
    params[:commodity].delete "category"
    @commodity = Commodity.new(params[:commodity])
    @commodity.category = @cat
    if @commodity.save
      redirect_to @commodity
    else
      @category = Category.new
      @categories = category_list
      render :new
    end
  end
end