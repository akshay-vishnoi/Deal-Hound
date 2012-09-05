class CommoditiesController < ApplicationController
 # before_filter(:only => [:new, :index]){ |controller| controller.authorize('admin')}
 #<%= image_tag @img.photo.url(:small) %>
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