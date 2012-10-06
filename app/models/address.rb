class Address < ActiveRecord::Base
  
  attr_accessible :city, :pincode, :state, :street

  # Validations
  validates :pincode, :numericality => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :street, :presence => true

  # Order Association
  has_many :orders
end
