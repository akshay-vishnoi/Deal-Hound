class Voucher < ActiveRecord::Base

  attr_accessible :commodity_id, :description, :redeem_within, :redeem_procedure, :title, :discount, :selling_price, :quantity
  
  validates :title, :presence => true, 
                    :uniqueness => true

  validates :redeem_within, :numericality => { :only_integer => true, 
                                               :greater_than => 0,
                                               :message => 'must be valid no. of days.'},
                            :allow_blank => true

  validates :selling_price, :numericality => { :greater_than_or_equal_to => 0, 
                                      :message => 'must be valid price'}

  validates :discount, :numericality => { :greater_than_or_equal_to => 0, 
                                      :message => 'must be valid price'}
  #Images association
  has_many :images, :as => :snapshot

  has_many :line_items, :as => :p_and_s

  has_one :deal, :as => :p_and_s
  #Commodity Association
  belongs_to :commodity
end
