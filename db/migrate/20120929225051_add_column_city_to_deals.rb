class AddColumnCityToDeals < ActiveRecord::Migration
  def change
    add_column :deals, :city, :string, :default => "Delhi"
  end
end
