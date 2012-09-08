class RenameColumnVenderInCommodities < ActiveRecord::Migration
  def change
    rename_column :commodities, :vender, :vendor 
  end
end
