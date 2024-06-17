require 'otp/mailer'

class User < ApplicationRecord
  include OTP::ActiveRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable, :timeoutable

  def email_otp
    OTP::Mailer.otp(email, otp, self).deliver_later
  end
end
