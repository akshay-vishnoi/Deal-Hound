class Order < ActiveRecord::Base
  attr_accessible :gift, :mailing_email, :payment_mode, :status, :user_id, :status_to_s, :payment_mode_to_s, :full_name
  
  

  belongs_to :user
  has_one :address
  has_many :line_items, :dependent => :destroy

  def status_to_s
    if status == 1
      return "Delivered"
    else
      return "Pending"
    end
  end

  def payment_mode_to_s
    if payment_mode == 0
      return "Wallet"
    else
      return "Credit Card"
    end
  end
end
