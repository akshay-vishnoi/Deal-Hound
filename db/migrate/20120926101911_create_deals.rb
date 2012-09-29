class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.integer :p_and_s_id
      t.string :p_and_s_type
      t.date :start_date
      t.date :end_date
      t.decimal :discount
      t.integer :max_users
      t.boolean :visible

      t.timestamps
    end
  end
end
