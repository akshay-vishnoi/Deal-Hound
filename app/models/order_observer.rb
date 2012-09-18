class OrderObserver < ActiveRecord::Observer
  def after_save(record)
    record.logger.info("#{record.mailing_email}")
  end
end
