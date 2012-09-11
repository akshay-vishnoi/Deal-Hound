class Cart < ActiveRecord::Base
  attr_accessible :user_id

  has_many :commodities
  has_many :line_items
end
