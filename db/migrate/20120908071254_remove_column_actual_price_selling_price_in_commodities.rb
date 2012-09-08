class RemoveColumnActualPriceSellingPriceInCommodities < ActiveRecord::Migration
  def change
    remove_column :commodities, :actual_price, :selling_price
  end
end
