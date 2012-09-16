class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.string :mailing_email
      t.text :mailing_address
      t.integer :status
      t.integer :payment_mode
      t.integer :gift

      t.timestamps
    end
  end
end
