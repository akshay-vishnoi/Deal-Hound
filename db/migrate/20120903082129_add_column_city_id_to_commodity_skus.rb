class AddColumnCityIdToCommoditySkus < ActiveRecord::Migration
  def change
    add_column :commodity_skus, :city_id, :integer
  end
end
