class CreateVoucherSkus < ActiveRecord::Migration
  def change
    create_table :voucher_skus do |t|
      t.string :code
      t.integer :voucher_id

      t.timestamps
    end
  end
end
