class RenameCommodityId < ActiveRecord::Migration
  def change
    rename_column :line_items, :commodity_id, :commodity_sku_id
  end
end
