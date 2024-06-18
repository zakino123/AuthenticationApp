class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
         :validatable, :two_factor_authenticatable, :trackable, :confirmable,
         :lockable, :timeoutable
  has_one_time_password(encrypted: true)
end
