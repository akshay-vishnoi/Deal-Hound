class Deal < ActiveRecord::Base
  # attr_accessible :commodity_id, :discount, :p_and_s :end_date, :max_users, :start_date, :visible
  attr_protected :none
  belongs_to :p_and_s, :polymorphic => true
  has_many :line_items

  validates :discount, :presence => true,
                       :numericality => true
  validates :max_quantity, :allow_blank => true,
                        :numericality => { :only_integer => true }                       
  validates :start_date, :presence => { :message => "Start date cant be blank."}
  validates :end_date, :presence => { :message => "End date cant be blank."}
  validate :date_validation#, :validate_date_with_others
  before_save :check_visibility


  def date_validation
    if !(self.start_date.nil? || self.end_date.nil?) && (self.start_date > self.end_date)
      self.errors.add(:start_date, "Please provide a valid duration.")
      self.errors.add(:end_date, "Please provide a valid duration.")
    end
  end

  def validate_date_with_others
    p_and_s = self.p_and_s
    other_deals = p_and_s.deals
    other_deals.each do |deal|
      if (self.start_date <= deal.start_date && self.end_date  >= deal.start_date) || (deal.start_date <= self.start_date && deal.end_date >= self.start_date)
        self.errors.add(:start_date, "There has been already a deal in this duration. #{deal.start_date} - #{deal.end_date}")
      end
    end
  end
end