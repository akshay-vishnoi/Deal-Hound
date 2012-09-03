class RemoveColumnCityFromCommodities < ActiveRecord::Migration
  def up
    remove_column :commodities, :city
  end

  def down
    add_column :commodities, :city, :string
  end
end
