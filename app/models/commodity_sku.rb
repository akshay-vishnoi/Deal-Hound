class CommoditySku < ActiveRecord::Base

  attr_accessible :color, :commodity_id, :quantity, :size

  validates :quantity, :allow_blank => true,  
                       :numericality => { :message => "Enter a valid quantity"}

  #Commodity association
  belongs_to :commodity, :inverse_of => :commodity_skus

  #LineItems association
  has_many :line_items, :as => :p_and_s

  #Cart association
  belongs_to :cart
end
