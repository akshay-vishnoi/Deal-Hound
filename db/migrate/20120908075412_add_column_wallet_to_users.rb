class AddColumnWalletToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wallet, :decimal, :precision => 2, :default => 0
  end
end
