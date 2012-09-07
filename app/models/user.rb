class User < ActiveRecord::Base
  attr_accessible :email, :mobile_no, :name, :wallet, :role, :password, :password_confirmation
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true
  has_secure_password

end
