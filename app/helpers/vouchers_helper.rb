module VouchersHelper
  def services_list
    Commodity.select('title').where('voucher = ?', 1).collect { |cat| cat.title }  
  end
end
