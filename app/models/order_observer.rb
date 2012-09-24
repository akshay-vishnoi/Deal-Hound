class OrderObserver < ActiveRecord::Observer
  def after_save(record)
    if(record.user.cart.line_items.any?)
      OrderNotifier.recieved(record, record.user.email).deliver
    end
  end

  def after_update(record)
    if(record.status == 1)
      OrderNotifier.shipped(record, record.user.email).deliver
      if(record.gift == 1)
        OrderNotifier.gift(record, record.mailing_email).deliver
      end
    end
  end
end
