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
  
  belongs_to :address
  accepts_nested_attributes_for :address
  
  has_many :line_items, :as => :item, :dependent => :destroy
  
  before_save :check_status
  
  def check_status
    if status.nil?
      self.status = 0
    end
  end

  def self.find_or_init_address(params)
    Address.find_or_initialize_by_street_and_city_and_state_and_pincode(params)
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
      if li.deal
        li.deal.update_attribute(:remaining_quantity, li.deal.remaining_quantity - li.quantity)
      end
      li.p_and_s.update_attribute(:quantity, li.p_and_s.quantity - li.quantity)
    end
  end

  def self.search(search, sort_column, sort_direction, page, admin)
    if admin
      search_pattern = "%#{search}%"
      where('(user_id in (select id from users where name like ?)) OR id LIKE ?', search_pattern, search_pattern).sort_paginate(sort_column, sort_direction, page)
    else
      where('user_id = ?', search).sort_paginate(sort_column, sort_direction, page)  
    end
  end
  
  def gift_to_s
    if gift == 1
      "Gifted"
    else 
      "Self"
    end
  end

  def self.sort_paginate(sort_column, sort_direction, page)
    order(sort_column + " " + sort_direction).paginate page: page, per_page: 10
  end
end