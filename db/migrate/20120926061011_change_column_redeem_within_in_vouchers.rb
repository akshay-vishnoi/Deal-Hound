class ChangeColumnRedeemWithinInVouchers < ActiveRecord::Migration
  def change
    change_column :vouchers, :redeem_within, :integer
  end
end
