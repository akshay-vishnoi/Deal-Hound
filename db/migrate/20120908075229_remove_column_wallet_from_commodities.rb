class RemoveColumnWalletFromCommodities < ActiveRecord::Migration
  def up
    remove_column :commodities, :wallet
  end

  def down
    add_column :commodities, :wallet, :string
  end
end
