class AddColumnDealIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :deal_id, :integer
  end
end
