class AddColumnDiscountToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :discount, :decimal, default: 0.0
  end
end
