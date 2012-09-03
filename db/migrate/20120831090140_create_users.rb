class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :wallet, default: true
      t.integer :mobile_no
      t.string :role, default: 'user'

      t.timestamps
    end
  end
end
