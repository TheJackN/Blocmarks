class RegistrationMailer < ApplicationMailer
  default from: "from@example.com"
  layout 'mailer'

  def welcome_email(user)
    @user = user
    mail(to: user.email, subject: "Welcome to the app")
  end
end
