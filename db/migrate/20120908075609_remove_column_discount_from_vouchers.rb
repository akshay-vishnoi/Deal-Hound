class RemoveColumnDiscountFromVouchers < ActiveRecord::Migration
  def up
    remove_column :vouchers, :discount
  end

  def down
    add_column :vouchers, :discount, :string
  end
end
