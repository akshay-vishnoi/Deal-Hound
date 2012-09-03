class RenameColumnTypeFromCommodities < ActiveRecord::Migration
  def change
    rename_column :commodities, :type, :delivery_type
  end
end
