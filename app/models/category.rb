class Category < ActiveRecord::Base
  attr_accessible :name
  validates :name, presence: true, uniqueness: true
  has_many :commodities
  accepts_nested_attributes_for :commodities
end
