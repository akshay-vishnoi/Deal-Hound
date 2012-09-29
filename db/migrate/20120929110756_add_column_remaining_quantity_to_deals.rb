class AddColumnRemainingQuantityToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :remaining_quantity, :integer
  end
end
