class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.text :street
      t.string :city
      t.string :state
      t.integer :pincode
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps
    end
  end
end
