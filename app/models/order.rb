class Order < ActiveRecord::Base

  attr_accessible :gift, :mailing_email, :payment_mode, :status, :user_id, :full_name, :status_to_s, :payment_mode_to_s, :address_attributes

  PAYMENT_MODES = {'Wallet' => 0, 'Credit Card' => 1}
  STATUS = { 'Pending' => 0, 'Shipped' => 1 }

  validates :mailing_email, :presence => true, 
                    :format => {
                      with: /(^[A-z0-9]+((.[A-z0-9]+)|(-[A-z0-9]+)|(_[A-z0-9]+)|([A-z0-9]+))*@[A-z0-9]{3,}.[A-z]{2,4}(.[A-z]{2})?)$/, 
                      message: "invalid email address"
                    }
  belongs_to :user
  has_one :address, :dependent => :destroy
  accepts_nested_attributes_for :address
  has_many :line_items, :as => :item, :dependent => :destroy
  before_save :check_status
  
  def check_status
    if status.nil?
      self.status = 0
    end
  end

  def status_to_s
    if status == 1
      return "Shipped"
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

  def add_line_items_from_cart(cart)
    cart.line_items.each do |li|
      li.update_attribute(:item, self)
    end
  end

  def self.search(search)
    if search
      search_pattern = "%#{search}%"
      where('(user_id in (select id from users where name like ?)) OR id LIKE ?', search_pattern, search_pattern)
    else
      scoped
    end
  end
  
  def self.for_user(id)
    where('user_id = ?', id)
  end

  def gift_to_s
    if gift == 1
      "Gifted"
    else 
      "Self"
    end
  end
end