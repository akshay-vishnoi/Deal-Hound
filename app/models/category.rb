class Category < ActiveRecord::Base

  attr_accessible :name

  # Validation
  validates :name, :presence => { :message => "Category can't be blank" }
  validates :name, :allow_blank => true, :uniqueness => { :case_sensitive => false, :message => "Category is already present" }
  
  # Commodity Association
  has_many :commodities, dependent: :destroy
  accepts_nested_attributes_for :commodities

  # Scopes
  scope :delete_multiple, lambda { |categories| destroy(categories) if(categories) }
  scope :sort_cat, order('name')

  # Class Methods
  # def self.sort_cat
  #   self.all.sort { |t1, t2| t1.name.downcase <=> t2.name.downcase }
  # end

  # Instance Methods
  def all_errors
    self.errors.messages[:name].join(', ')
  end
end