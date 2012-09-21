class OrderObserver < ActiveRecord::Observer
  def after_save(record)
    OrderNotifier.recieved(record).deliver
  end
end
