class UserMailer < ApplicationMailer
  def otp_email(user, qr_code)
    @user = user
    @qr_code = qr_code
    mail(to: @user.email, subject: 'Your One-Time Password')
  end
end
