class User < ApplicationRecord
  has_one_time_password after_column_name: :last_otp_at, backup_codes_count: 6, one_time_backup_codes: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable, :lockable, :timeoutable
end
