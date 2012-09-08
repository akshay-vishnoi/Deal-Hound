class RemoveColumnNatureFromCategories < ActiveRecord::Migration
  def up
    remove_column :categories, :nature
  end

  def down
    add_column :categories, :nature, :string
  end
end
