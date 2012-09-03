class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities do |t|
      t.integer :category_id
      t.string :title
      t.string :city
      t.text :features
      t.decimal :actual_price
      t.decimal :selling_price
      t.text :description
      t.string :type

      t.timestamps
    end
  end
end
