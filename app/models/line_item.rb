class LineItem < ActiveRecord::Base
  attr_accessible :cart_id, :commodity_id, :order_id, :price, :quantity
end
