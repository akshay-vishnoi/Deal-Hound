class Subscribe < ActiveRecord::Base
  attr_accessible :email

  validates :email, :presence => { message: "Subscribe email can't be blank."},
                    :format => {
                      with: /(^[A-z0-9]+((.[A-z0-9]+)|(-[A-z0-9]+)|(_[A-z0-9]+)|([A-z0-9]+))*@[A-z0-9]{3,}.[A-z]{2,4}(.[A-z]{2})?)$/, 
                      message: "invalid email address"
                    }, 
                    :uniqueness => true

end
