class CreateVouchers < ActiveRecord::Migration
  def change
    create_table :vouchers do |t|
      t.string :title
      t.text :description
      t.text :redeem_procedure
      t.date :redeem_date
      t.integer :commodity_id

      t.timestamps
    end
  end
end
