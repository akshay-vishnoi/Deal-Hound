class Category < ActiveRecord::Base

  attr_accessible :name

  #Validation
  validates :name, :presence => { :message => "Category can't be blank" }, 
                   :uniqueness => { :message => "Category is already present" }
  
  #Commodity Association
  has_many :commodities, dependent: :destroy
  accepts_nested_attributes_for :commodities
end