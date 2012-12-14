class Deal < ActiveRecord::Base
  
  # attr_accessible :commodity_id, :discount, :p_and_s :end_date, :max_users, :start_date, :visible
  attr_protected :none

  # Validation
  validates :discount, :numericality => true

  validates :max_quantity, :allow_blank => true,  
                           :numericality => { greater_than_or_equal_to: 0, 
                                          :only_integer => true, 
                                          :message => "Enter a valid quantity"}

  validates :start_date, :presence => { :message => "Start date can't be blank." }
  validates :start_date, :date => { :before => :end_date }, 
                         :unless => proc { |deal| deal.start_date.blank? }
  
  validates :end_date, :presence => { :message => "End date can't be blank."}
  validates :end_date, :date => { :after => :end_date }, 
                       :unless => proc { |deal| deal.end_date.blank? }

  validate :validate_date_with_others
  
  # Callbacks
  before_save :check_visibility
  
  # Product and Services Association
  belongs_to :p_and_s, :polymorphic => true
  
  # Line Items Associations
  has_many :line_items

  # Instance Methods
  def validate_date_with_others
    p_and_s = self.p_and_s
    other_deals = p_and_s.deals if p_and_s # p_and_s.try(:deals)
    other_deals = other_deals.where('id != ?', self.id) if self.id
    if other_deals
      other_deals.each do |deal|
        if ((self.start_date <= deal.start_date && self.end_date  >= deal.start_date) || (deal.start_date <= self.start_date && deal.end_date >= self.start_date)) && deal != self
          self.errors.add(:start_date, "There has been already a deal in this duration. #{deal.start_date} - #{deal.end_date}")
        end
      end
    end
  end

  def self.search(search)
      where('city = ? AND visible = "true"',search)
  end
end