class City < ActiveRecord::Base

  attr_accessible :name
  has_many :commodity_skus
  has_many :commodities, :through => :commodity_skus
end
