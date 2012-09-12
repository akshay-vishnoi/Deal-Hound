class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :commodity_sku_id, :order_id, :price, :quantity

  belongs_to :cart
  belongs_to :commodity_sku, :inverse_of => :line_items

  def total_price
    commodity_sku.commodity.selling_price * quantity
  end
end
