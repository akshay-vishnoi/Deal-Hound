class RemoveColumnMailingAddressFromOrders < ActiveRecord::Migration
  def up
    remove_column :orders, :mailing_address
  end

  def down
    add_column :orders, :mailing_address, :string
  end
end
