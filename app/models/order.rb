class Order < ActiveRecord::Base
  attr_accessible :gift, :mailing_email, :payment_mode, :status, :user_id, :full_name, :status_to_s, :payment_mode_to_s

  PAYMENT_TYPES = ['Wallet', 'Credit Card']
  PAYMENT_MODES = {}
  PAYMENT_TYPES.each_index{ |i| PAYMENT_MODES[PAYMENT_TYPES[i]] = i}

  validates :mailing_email, :presence => true, 
                    :format => {
                      with: /(^[A-z0-9]+((.[A-z0-9]+)|(-[A-z0-9]+)|(_[A-z0-9]+)|([A-z0-9]+))*@[A-z0-9]{3,}.[A-z]{2,4}(.[A-z]{2})?)$/, 
                      message: "invalid email address"
                    }
  belongs_to :user
  has_one :address
  has_many :line_items, :as => :item, :dependent => :destroy
  before_save :check_status
  
  def check_status
    print "hello"
    self.status = 0
  end

  def status_to_s
    if status == 1
      return "Delivered"
    else
      return "Pending"
    end
  end

  def payment_mode_to_s=(payment)
    if payment == PAYMENT_TYPES[0]
      mailing_email = 1
      status = 0
    else
      status = 1
    end
  end
  def payment_mode_to_s
    if payment_mode == 0
      PAYMENT_TYPES[0]
    else
      PAYMENT_TYPES[1]
    end
  end
end
