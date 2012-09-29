class AddColumnQuantityToVouchers < ActiveRecord::Migration
  def change
    add_column :vouchers, :quantity, :integer
  end
end
