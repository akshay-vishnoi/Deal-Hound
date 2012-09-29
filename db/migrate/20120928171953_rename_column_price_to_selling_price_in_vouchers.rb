class RenameColumnPriceToSellingPriceInVouchers < ActiveRecord::Migration
  def change
    rename_column :vouchers, :price, :selling_price
  end
end
