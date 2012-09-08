module CommodityHelper
  def category_list
    Category.select('name').collect { |cat| cat.name }
  end
end
