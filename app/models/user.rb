class User < ActiveRecord::Base

  attr_accessible :email, :mobile_no, :name, :wallet, :admin, :password, :password_confirmation, :user_name

  #Validation
  validates :user_name, :presence => true, 
                        :format => {
                          with: /[A-z][A-z0-9]*([-_.][A-z0-9])*/, 
                          message: "Invalid format"
                        }, 
                        :uniqueness => { :case_sensitive => false }

  validates :email, :presence => true,
                    :format => {
                      with: /(^[A-z0-9]+((.[A-z0-9]+)|(-[A-z0-9]+)|(_[A-z0-9]+)|([A-z0-9]+))*@[A-z0-9]{3,}.[A-z]{2,4}(.[A-z]{2})?)$/, 
                      message: "invalid email address"
                    }, 
                    :uniqueness => true

  validates :mobile_no, :numericality => true, 
                        :allow_blank => true

  validates :password, :presence => true, 
                       :length => { :within => 8..20},
                       :confirmation => { :message => "Password does not match" }, 
                       :if => :password

  before_validation :strip_whitespace!, :only => [:name, :email, :user_name]

  def strip_whitespace! 
    self.name.strip!
    self.user_name.strip!
    self.email.strip!
  end

  has_secure_password

  has_one :cart
  has_many :orders

  scope :main_admin, where('user_name = "a" AND admin = 1')
end
