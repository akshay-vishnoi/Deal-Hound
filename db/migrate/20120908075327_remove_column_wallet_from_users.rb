class RemoveColumnWalletFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :wallet
  end

  def down
    add_column :users, :wallet, :string
  end
end
