class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :deals, :discount, :decimal, :precision => 5, :scale => 2, :default => 0
    change_column :vouchers, :discount, :decimal, :precision => 5, :scale => 2, :default => 0
    change_column :users, :wallet, :decimal, :precision => 30, :scale => 2, :default => 0
    change_column :vouchers, :selling_price, :decimal, :precision => 20, :scale => 2, :default => 0
  end

  def down
  end
end
