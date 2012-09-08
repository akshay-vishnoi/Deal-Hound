class AddColumnVoucherToCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :voucher, :integer
  end
end
