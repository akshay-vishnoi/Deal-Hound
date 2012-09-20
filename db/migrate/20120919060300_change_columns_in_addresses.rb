class ChangeColumnsInAddresses < ActiveRecord::Migration
  def change
    rename_column :addresses, :addressable_id, :order_id
    remove_column :addresses, :addressable_type
  end
end
