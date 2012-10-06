class VoucherSku < ActiveRecord::Base
  attr_accessible :code, :voucher_id
  belongs_to :voucher
end
