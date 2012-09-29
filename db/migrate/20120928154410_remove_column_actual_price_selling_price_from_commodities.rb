class RemoveColumnActualPriceSellingPriceFromCommodities < ActiveRecord::Migration
  def up
    remove_column :commodities, :actual_price
    remove_column :commodities, :selling_price
  end

  def down
    add_column :commodities, :selling_price, :string
    add_column :commodities, :actual_price, :string
  end
end
