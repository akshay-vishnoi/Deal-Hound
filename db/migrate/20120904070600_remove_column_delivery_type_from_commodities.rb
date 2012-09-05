class RemoveColumnDeliveryTypeFromCommodities < ActiveRecord::Migration
  def up
    remove_column :commodities, :delivery_type
  end

  def down
    add_column :commodities, :delivery_type, :string
  end
end
