class Address < ActiveRecord::Base
  
  attr_accessible :city, :pincode, :state, :street

  # Validations
  validates :city, :state, :street, :pincode, :presence => true
  validates :pincode, :allow_blank => true, :numericality => true

  # Order Association
  has_many :orders
end
