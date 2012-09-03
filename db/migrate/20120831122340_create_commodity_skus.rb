class CreateCommoditySkus < ActiveRecord::Migration
  def change
    create_table :commodity_skus do |t|
      t.integer :quantity
      t.string :color
      t.string :size
      t.integer :commodity_id

      t.timestamps
    end
  end
end
