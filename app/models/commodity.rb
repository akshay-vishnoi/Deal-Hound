class Commodity < ActiveRecord::Base
  attr_accessible :title, :features, :actual_price, :selling_price, :description, :delivery_type, :vender, :images_attributes, :commodity_skus_attributes
  validates :title, presence: true, uniqueness: true
  DELIVERY_TYPE = ['Physical', 'Voucher']
  belongs_to :category
  
  has_many :commodity_skus, :dependent => :destroy
 
  has_many :images, :as => :snapshot, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['photo'].nil?}
  accepts_nested_attributes_for :commodity_skus, :reject_if => lambda { |t| t['size'].empty? && t['color'].empty? && t['quantity'].empty? }
end