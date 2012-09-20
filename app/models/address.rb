class Address < ActiveRecord::Base
  attr_accessible :addressable_id, :addressable_type, :city, :pincode, :state, :street
  belongs_to :order
  validates :pincode, :numericality => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :street, :presence => true
end
