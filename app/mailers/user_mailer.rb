class UserMailer < ActionMailer::Base  
  default :from => "ServiceCrunch@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.signup_confirmation.subject
  #
  def new_message(message)
    @message = message
    mail(:to => "gary.riger@gmail.com", :subject => "Service Crunch User Contact Form")
  end
end
