class AddColumnNatureToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :nature, :string, defualt: 'Product'
  end
end
