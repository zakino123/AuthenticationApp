class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :registerable, :recoverable, :rememberable, :validatable, :trackable,
         :confirmable, :lockable, :timeoutable, :two_factor_authenticatable,
         :otp_secret_encryption_key => '16e752ff8f715fe81f7005d266841081865be430fd5e79f4dc2390f179c5e1ff7c8534e321aadb32b75eb2d861b50dc9b69b4ef62b4e6f0ccf6434ba2299f554'
end
