class CommoditySku < ActiveRecord::Base
  attr_accessible :color, :commodity_id, :quantity, :size, :city_ids
  belongs_to :commodity
  belongs_to :city
end
