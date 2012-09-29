class AddColumnPriceToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :price, :decimal, :precision => 2, :default => 0.0
  end
end
