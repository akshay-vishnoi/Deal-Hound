class CommoditiesController < ApplicationController
before_filter(:only => [:new, :create, :delete, :edit]){ |controller| controller.authorize('admin')}
  def index
    @commodities = Commodity.all
  end

  def new
    @category = Category.new
    @categories = Category.select('name').collect { |cont| cont.name }
    @commodity = Commodity.new
    3.times { @commodity.images.build }
    2.times { @commodity.commodity_skus.build }
    respond_to do |format|
      format.html
    end
  end

  def show
    @commodity = Commodity.find_by_id(params[:id])
  end

  def edit
    @categories = Category.select('name').collect { |cont| cont.name }
    @category = Category.new
    @commodity = Commodity.find(params[:id])
    params[:edit_img] = @commodity.images.empty?
    2.times { @commodity.images.build }
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
      redirect_to request.referrer, notice: "Image deleted #{params}"
    end
  end

  def del_image
    Image.destroy(params[:image_id])
    redirect_to request.referrer, notice: "Image deleted #{params}"
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
    if @commodity.save
      respond_to do |format|
        format.html { redirect_to @commodity }
      end
    else
      redirect_to login_url, notice: "#{params}, #{@cat}"
    end 
  end
end