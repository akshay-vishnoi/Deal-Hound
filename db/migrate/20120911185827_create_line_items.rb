class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :commodity_id
      t.integer :cart_id
      t.integer :quantity
      t.integer :order_id
      t.decimal :price, :precision => 2

      t.timestamps
    end
  end
end
