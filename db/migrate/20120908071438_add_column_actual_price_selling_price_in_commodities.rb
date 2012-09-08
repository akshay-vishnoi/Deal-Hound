class AddColumnActualPriceSellingPriceInCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :actual_price, :decimal, :precision => 2
    add_column :commodities, :selling_price, :decimal, :precision => 2
  end
end
