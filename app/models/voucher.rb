class Voucher < ActiveRecord::Base
  attr_accessible :commodity_id, :description, :redeem_date, :redeem_procedure, :title
  has_many :images, :as => :snapshot
end
