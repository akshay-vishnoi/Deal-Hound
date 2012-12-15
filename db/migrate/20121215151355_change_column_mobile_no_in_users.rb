class ChangeColumnMobileNoInUsers < ActiveRecord::Migration
  def up
    change_column :users, :mobile_no, :string
  end

  def down
  end
end
