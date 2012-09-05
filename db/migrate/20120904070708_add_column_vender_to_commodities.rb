class AddColumnVenderToCommodities < ActiveRecord::Migration
  def change
    add_column :commodities, :vender, :string
  end
end
