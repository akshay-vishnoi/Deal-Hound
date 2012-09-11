class Category < ActiveRecord::Base

  attr_accessible :name

  #Validation
  validates :name, presence: true, uniqueness: true
  
  #Commodity Association
  has_many :commodities, dependent: :destroy
  accepts_nested_attributes_for :commodities
end