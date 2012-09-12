class Cart < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :commodity_skus
  has_many :line_items, :dependent => :destroy

  def add_item(commodity_sku_id, price, quantity)
    current_item = line_items.find_by_commodity_sku_id(commodity_sku_id)
    if current_item
      current_item.quantity += quantity.to_i
    else
      current_item = line_items.build(commodity_sku_id: commodity_sku_id)
      current_item.price = price
      current_item.quantity = quantity
    end
    current_item
  end
end
