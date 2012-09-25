class AddColumnActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authenticate_link, :string
  end
end
