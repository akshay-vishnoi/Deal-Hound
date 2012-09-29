class AddColumnSellingPriceActualPriceToCommoditySkus < ActiveRecord::Migration
  def change
    add_column :commodity_skus, :selling_price, :decimal, :precision => 20, :scale => 2
    add_column :commodity_skus, :actual_price, :decimal, :precision => 20, :scale => 2
  end
end
