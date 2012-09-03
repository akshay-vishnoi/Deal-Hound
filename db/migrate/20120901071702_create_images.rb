class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :snapshot_id
      t.string :snapshot_type

      t.timestamps
    end
  end
end
