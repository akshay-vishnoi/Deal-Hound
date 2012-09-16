class Address < ActiveRecord::Base
  attr_accessible :addressable_id, :addressable_type, :city, :pincode, :state, :street
end
