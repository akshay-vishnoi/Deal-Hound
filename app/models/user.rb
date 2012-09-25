class User < ActiveRecord::Base

  attr_accessible :email, :mobile_no, :name, :wallet, :admin, :password, :password_confirmation, :user_name, :authenticate_link

  #Validation
  validates :user_name, :presence => true, 
                        :format => {
                          with: /[A-z][A-z0-9]*([-_.][A-z0-9])*/, 
                          message: "Invalid format"
                        }, 
                        :uniqueness => { :case_sensitive => false }

  validates :email, :on => :create, 
                    :presence => true,
                    :format => {
                      with: /(^[A-z0-9]+((.[A-z0-9]+)|(-[A-z0-9]+)|(_[A-z0-9]+)|([A-z0-9]+))*@[A-z0-9]{3,}.[A-z]{2,4}(.[A-z]{2})?)$/, 
                      message: "invalid email address"
                    }, 
                    :uniqueness => true

  validates :mobile_no, :numericality => { greater_than_or_equal_to: 0, 
                                           :only_integer => true, 
                                           message: 'must be a valid mobile'}, 
                        :allow_blank => true

  validates :password, :if => :password, 
                       :presence => true, 
                       :length => { :within => 8..20},
                       :confirmation => { :message => "Password does not match" }
  validates :wallet, :allow_blank => true, 
                     :numericality => { greater_than_or_equal_to: 0, 
                                        message: 'must be a valid price'}

  before_validation :strip_whitespace!, :only => [:name, :email, :user_name]

  def strip_whitespace! 
    self.name.strip!
    self.user_name.strip!
    self.email.strip!
  end

  def self.search(search, user)
    if search
      search_pattern = "%#{search}%"
      where('user_name != ? AND ((name LIKE ?) OR (id like ?) OR (email LIKE ?) OR (wallet > ?)) ', user.user_name, search_pattern, search_pattern, search_pattern, search)
    else
      scoped
    end
  end


  has_secure_password

  has_one :cart, :dependent => :destroy
  has_many :orders

  scope :main_admin, where('user_name = "a" AND admin = 1')
end
