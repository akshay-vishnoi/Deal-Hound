class User < ActiveRecord::Base

  attr_accessible :email, :mobile_no, :name, :wallet, :admin, :password, :password_confirmation

  #Validation
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, format: {
    with: /(^[A-z0-9]+((.[A-z0-9]+)|(-[A-z0-9]+)|(_[A-z0-9]+)|([A-z0-9]+))*@[A-z0-9]{3,}.[A-z]{2,4}(.[A-z]{2})?)$/, 
    message: "invalid email address"
  }
  validates :password, :presence => true,
                       :confirmation => true, 
                       :length => { :within => 8..20}, 
                       :on => :create
  validates :password, :allow_blank => true,
                       :confirmation => true, 
                       :length => { :within => 8..20}, 
                       :on => :update                     
  has_secure_password

end
