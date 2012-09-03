class CommoditiesController < ApplicationController
 # before_filter(:only => [:new, :index]){ |controller| controller.authorize('admin')}
  def index
    @img = Image.first
    respond_to do |format|
      format.html
    end
  end
  def new
    @category = Category.new
    @cities = City.select('name').collect { |city| city.name }
    @categories = Category.select('name').collect { |cat| cat.name }
    @commodity = Commodity.new
    3.times { @commodity.images.build }
    @commodity.commodity_skus.build  
    respond_to do |format|
      format.html
    end
  end
  def create
    @cat = Category.find_by_name(params[:commodity]["category"])
    params[:commodity].delete_if { |k,v| k == "category" }
    @commodity = Commodity.new(params[:commodity])
    @commodity.category = @cat
    @commodity.save
    if false
      respond_to do |format|
        format.html { redirect_to commodities_path }
      end
    else
      redirect_to login_url, notice: "#{params}, #{@cat}"
    end    
  end
end