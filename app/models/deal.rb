class Deal < ActiveRecord::Base
  # attr_accessible :commodity_id, :discount, :p_and_s :end_date, :max_users, :start_date, :visible
  attr_protected :none
  belongs_to :p_and_s, :polymorphic => true

  validates :discount, :presence => true,
                       :numericality => true
  validates :max_users, :allow_blank => true,
                        :numericality => { :only_integer => true }                       
  validates :start_date, :presence => { :message => "Start date cant be blank."}
  validates :end_date, :presence => { :message => "End date cant be blank."}
  validate :date_validation

  def date_validation
    if !(self.start_date.nil? || self.end_date.nil?) && (self.start_date > self.end_date)
      self.errors.add(:start_date, "Please provide a valid duration.")
      self.errors.add(:end_date, "Please provide a valid duration.")
    end
  end
end
