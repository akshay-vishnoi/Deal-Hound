class AddColumnDiscountToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :discount, :decimal, :precision => 2, :default => 0.0
  end
end
