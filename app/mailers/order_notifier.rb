class OrderNotifier < ActionMailer::Base
  default from: "DealHound.com <mail@dealhound.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.recieved.subject
  #
  def recieved(order)
    @order = order
    mail to: @order.mailing_email, subject: "DealHound Order No. #{@order.id} Confirmation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped(order)
    @order = order
    mail to: @order.mailing_email, subject: "DealHound Order No. #{@order.id} Shipped"
  end
end
