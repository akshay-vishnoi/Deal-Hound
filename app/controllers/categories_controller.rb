class CategoriesController < ApplicationController
  def new
    @category = Category.new
    respond_to do |format|
      format.html
    end
  end
  def create
    @category = Category.new(params[:category])
    if @category.save
      respond_to do |format|
        format.html { redirect_to new_commodity_path, notice: "#{@category.name.capitalize} has been added."}
      end
    end
  end
end
