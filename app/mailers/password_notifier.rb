class PasswordNotifier < ActionMailer::Base
  default from: "DealHound.com <mail@dealhound.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_notifier.reset_password.subject
  #
  def reset_password(user, authentication_path)
    @user = user
    @authentication_path = authentication_path
    mail to: @user.email, subject: "DealHound User forget password"
  end
end
