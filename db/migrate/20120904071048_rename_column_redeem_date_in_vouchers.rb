class RenameColumnRedeemDateInVouchers < ActiveRecord::Migration
  def change
    rename_column :vouchers, :redeem_date, :redeem_within
  end
end
