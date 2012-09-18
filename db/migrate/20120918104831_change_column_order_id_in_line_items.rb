class ChangeColumnOrderIdInLineItems < ActiveRecord::Migration
  def change
    rename_column :line_items, :commodity_sku_id, :item_id
    rename_column :line_items, :cart_id, :item_type
    change_column :line_items, :item_type, :string
    rename_column :line_items, :order_id, :p_and_s_id
    add_column :line_items, :p_and_s_type, :string
  end
end
