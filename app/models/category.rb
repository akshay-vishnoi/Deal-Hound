class Category < ActiveRecord::Base

  attr_accessible :name

  #Validation
  validates :name, :presence => { :message => "Category can't be blank" }, 
                   :uniqueness => { :message => "Category is already present" }
  
  #Commodity Association
  has_many :commodities, dependent: :destroy
  accepts_nested_attributes_for :commodities

  scope :delete_multiple, lambda { |categories| destroy(categories) if(categories) }

  def self.sort_cat
    self.all.sort { |t1, t2| t1.name.downcase <=> t2.name.downcase }
  end
end