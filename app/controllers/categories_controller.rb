class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    respond_to do |format|
      if @category.save
        format.html { redirect_to new_commodity_path, notice: "#{@category.name.capitalize} has been added."}
      else
        flash[:error] = "#{@category.errors.get(:name).join(', ')}"
        format.html { redirect_to request.referrer }
      end
    end
  end
end