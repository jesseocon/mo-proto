class UserMailer < ActionMailer::Base
  default from: "from@example.com"
  default_url_options[:host] = "localhost:3000"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
  
  def account_verfication(user)
    @user = user
    mail :to => user.email, :subject => "Account Verification"
  end
  
  def account_verification_instructions(user)
    @user = user
    @confirm_account_url = verification_url(user.verification_token)
    mail :to => user.email, :subject => "Validate your details"
  end
end