class CommoditiesController < ApplicationController
  include CommodityHelper

  before_filter(:only => [:new, :create, :delete, :edit]) { |controller| controller.authorize(1) }
  
  def index
    @commodities = Commodity.all
    @cart = Cart.find(3)
  end

  def new
    @category = Category.new
    @categories = category_list
    @commodity = Commodity.new
    @commodity.images.build
    @commodity.commodity_skus.build
  end

  def show
    @commodity = Commodity.find_by_id(params[:id])
  end

  def edit
    @categories = category_list
    @category = Category.new
    @commodity = Commodity.find(params[:id])
    params[:selected_category] = @commodity.category.name
    params[:edit_img] = !(@commodity.images.empty?)
    @commodity.images.build
    @commodity.commodity_skus.build    
  end

  def show_category
    @category = Category.find(params["category_id"])
    @commodities = @category.commodities
    render 'commodities/index'
  end

  def update
    @cat = Category.find_by_name(params[:commodity]["category"])
    params[:commodity].delete_if { |k,v| k == "category" }
    @commodity = Commodity.find(params[:id])
    @commodity.category = @cat
    if @commodity.update_attributes(params[:commodity])
      redirect_to commodities_url, notice: "Update successful"
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
    params[:commodity].delete_if { |k,v| k == "category" }
    @commodity = Commodity.new(params[:commodity])
    @commodity.category = @cat
    respond_to do |format|
      if @commodity.save
        format.html { redirect_to @commodity }
      else
        @category = Category.new
        @categories = category_list
        format.html { render :new }
      end
    end 
  end
end