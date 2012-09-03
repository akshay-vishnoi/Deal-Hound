class Commodity < ActiveRecord::Base
  attr_accessible :title, :features, :actual_price, :selling_price, :description, :delivery_type, :city_ids
  validates :title, presence: true, uniqueness: true
  DELIVERY_TYPE = ['Physical', 'Voucher']
  belongs_to :category
  
  has_many :commodity_skus
  has_many :cities, :through => :commodity_skus
 
  has_many :images, :as => :snapshot
  accepts_nested_attributes_for :commodity_skus, :images, :reject_if => lambda { |t| t['photo'].nil?}
end