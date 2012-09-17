class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def edit
      
  end

  def index
    @categories = Category.all.sort! { |t1, t2| t1.name.downcase <=> t2.name.downcase }
  end

  def create
    @category = Category.new(params[:category])
    respond_to do |format|
      if @category.save
        format.html { redirect_to request.referrer, notice: "#{@category.name.capitalize} has been added."}
      else
        flash[:error] = "#{@category.errors.get(:name).join(', ')}"
        format.html { redirect_to request.referrer }
      end
    end
  end

  def edit_delete
    @rejected_categories = Category.update(params[:category_ids1].keys, params[:category_ids1].values).reject { |c| c.errors.empty? }
    if params[:category_ids]
      Category.delete_multiple(params[:category_ids])
    end
    if @rejected_categories.empty?
      flash[:notice] = "Categories updated"
      redirect_to categories_url
    else
      flash[:error] = @rejected_categories.map { |rc| rc.errors.messages[:name].join(', ') }.join(', ')
      render :action => :index
    end
  end
end