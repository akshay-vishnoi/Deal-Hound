class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :commodity_sku_id, :order_id, :price, :quantity, :deal_id

  belongs_to :item, :polymorphic => true
  belongs_to :p_and_s, :polymorphic => true
  belongs_to :deal

  def total_price
    price * quantity
  end
end