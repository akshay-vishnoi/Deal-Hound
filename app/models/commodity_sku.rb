class CommoditySku < ActiveRecord::Base

  attr_accessible :color, :commodity_id, :quantity, :size, :actual_price, :selling_price

  validates :quantity, :allow_blank => true,  
                       :numericality => { greater_than_or_equal_to: 0, 
                                          :only_integer => true, 
                                          :message => "Enter a valid quantity"}

  validates :actual_price, :allow_blank => true, 
                           numericality: { greater_than_or_equal_to: 0.01, 
                                           message: 'Enter valid actual price'}

  validates :selling_price, :allow_blank => true, 
                            numericality: { greater_than_or_equal_to: 0.01, 
                                            message: 'Enter valid selling price'}

  validates :size, :uniqueness => { :scope => [:color, :commodity_id], 
                                    :message => "Size and Color already present." }
  
  # Commodity association
  belongs_to :commodity, :inverse_of => :commodity_skus

  # LineItems association
  has_many :line_items, :as => :p_and_s

  # Deals association
  has_many :deals, :as => :p_and_s
end
