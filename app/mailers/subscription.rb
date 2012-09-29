class Subscription < ActionMailer::Base
  default from: "DealHound.com <mail@dealhound.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.subscription.send_updates.subject
  #
  def send_updates(email)
    @email = email 
    mail to: @email, subject: "DealHound Updates"
  end
end
