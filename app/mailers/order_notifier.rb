class OrderNotifier < ActionMailer::Base
  default from: "DealHound.com <mail@dealhound.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.recieved.subject
  #
  def recieved(order, email)
    @order = order
    mail to: email, subject: "DealHound Order No. #{@order.id} Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order, email)
    @order = order
    mail to: email, subject: "DealHound Order No. #{@order.id} Shipped"
  end

  def gift(order, email)
    @order = order
    mail to: email, subject: "Gift from #{@order.user.name}"
  end

  def send_vouchers(order, vouchers_codes, voucher, email)
    @vouchers_codes = vouchers_codes
    @voucher = voucher
    @order = order
    mail to: email, subject: "Gift from"
  end
end
