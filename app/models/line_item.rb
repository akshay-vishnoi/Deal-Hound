class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :commodity_sku_id, :order_id, :price, :quantity

  belongs_to :item, :polymorphic => true
  belongs_to :p_and_s, :polymorphic => true

  def total_price
    p_and_s.commodity.selling_price * quantity
  end
end
