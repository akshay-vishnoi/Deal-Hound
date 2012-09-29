class RenameColumnMaxUsersToMaxQuantityInDeals < ActiveRecord::Migration
  def change
    rename_column :deals, :max_users, :max_quantity
  end
end
