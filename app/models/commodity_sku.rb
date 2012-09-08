class CommoditySku < ActiveRecord::Base

  attr_accessible :color, :commodity_id, :quantity, :size

  #Commodity association
  belongs_to :commodity
end
