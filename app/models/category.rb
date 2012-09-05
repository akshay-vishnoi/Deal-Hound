class Category < ActiveRecord::Base
  attr_accessible :name, :nature
  validates :name, presence: true, uniqueness: true
  NATURES = [ 'Product', 'Service']
  validates :nature, inclusion: NATURES
  has_many :commodities, dependent: :destroy
  accepts_nested_attributes_for :commodities
end
