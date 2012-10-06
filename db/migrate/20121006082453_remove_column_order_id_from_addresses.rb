class RemoveColumnOrderIdFromAddresses < ActiveRecord::Migration
  def up
    remove_column :addresses, :order_id
  end

  def down
    add_column :addresses, :order_id, :string
  end
end
