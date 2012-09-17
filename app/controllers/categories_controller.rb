class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def edit
      
  end

  def index
    @categories = Category.sort_cat
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      redirect_to request.referrer, notice: "#{@category.name.capitalize} has been added."
    else
      flash[:error] = "#{@category.errors.get(:name).join(', ')}"
      redirect_to request.referrer
    end
  end

  def edit_delete
    @rejected_categories = Category.update(params[:category_ids1].keys, params[:category_ids1].values).reject { |c| c.errors.empty? }
    Category.delete_multiple(params[:category_ids])
    if @rejected_categories.empty?
      flash[:notice] = "Categories updated"
      redirect_to categories_url
    else
      errors = @rejected_categories.map { |rc| rc.all_errors }
      flash[:error] = errors.join(', ')
      @categories = Category.sort_cat
      render :action => :index
    end
  end
end