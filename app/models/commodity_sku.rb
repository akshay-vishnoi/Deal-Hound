class CommoditySku < ActiveRecord::Base
  attr_accessible :color, :commodity_id, :quantity, :size
  belongs_to :commodity
end
