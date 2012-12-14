class OrderObserver < ActiveRecord::Observer
  def after_save(record)
    if(record.user.cart.line_items.any?)
      OrderNotifier.recieved(record, record.user.email).deliver
      Rails.logger.info(record.user.cart.line_items)
    end
  end

  def after_update(record)
    if(record.status == 1)
      OrderNotifier.shipped(record, record.user.email).deliver
      if(record.gift == 1)
        OrderNotifier.gift(record, record.mailing_email).deliver
      end
      record.line_items.each do |item|
        if(item.p_and_s_type == "Voucher")
          voucher_codes = generate_voucher_code(item.p_and_s, item.quantity)
          puts voucher_codes
          OrderNotifier.send_vouchers(record, voucher_codes, item.p_and_s, record.mailing_email).deliver
        end
      end
    end
  end

  private

  def generate_voucher_code(voucher, quantity)
    codes = []
    quantity.times do
      code = SecureRandom.hex 4
      @voucher_sku = VoucherSku.where('voucher_id = ? AND code = ?', voucher.id, code)
      unless @voucher_sku.nil?
        code = SecureRandom.hex 4
        @voucher_sku = VoucherSku.where('voucher_id = ? AND code = ?', voucher.id, code)  
      end
      codes << code
      voucher.voucher_skus.create(:code => code)
    end
    codes
  end
end
