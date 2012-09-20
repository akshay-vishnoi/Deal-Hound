public

def voucher
  self.line_items.each do |li|
    if li.p_and_s_type = "CommoditySku"
      return 1
    end
  end
  return 0
end

def total_price
    line_items.to_a.sum { |item| item.total_price }
end