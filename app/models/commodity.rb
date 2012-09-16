class Commodity < ActiveRecord::Base

  attr_accessible :title, :features, :actual_price, :selling_price, :description, :delivery_type, :vendor, :voucher, :images_attributes, :commodity_skus_attributes
  TYPE = { "Product" => 0, "Service" => 1 }

  #Validation
  validates :title, :presence => true, 
                    :uniqueness => true
  
  validates :actual_price, :allow_blank => true, 
                           :numericality => true

  validates :selling_price, :allow_blank => true, 
                            :numericality => true

  :before_save :price_setting
  #Category Association
  belongs_to :category
  
  #CommoditySku Association
  has_many :commodity_skus, :dependent => :destroy, :inverse_of => :commodity
  accepts_nested_attributes_for :commodity_skus, :reject_if => lambda { |t| t['size'].empty? && t['color'].empty? && t['quantity'].empty? }

  #Images Association
  has_many :images, :as => :snapshot, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil?}
end