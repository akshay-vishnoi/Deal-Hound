public

def voucher
  self.line_items.each do |li|
    if li.p_and_s_type === "CommoditySku"
      return true
    end
  end
  return false
end

def total_price
    line_items.to_a.sum { |item| item.total_price }
end

def check_visibility(time = Time.now)
  if(self.end_date.to_time < time || self.start_date.to_time > time || self.remaining_quantity < 1 )
    self.visible = false
    true
  else
    self.visible = true
  end
end