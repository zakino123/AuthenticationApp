class AddOtpSecretKeyToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :two_factor_authentication_token, :string
    add_column :users, :otp_secret_key, :string
    add_column :users, :last_otp_at, :integer
    add_column :users, :otp_backup_codes, :json

    add_index :users, :two_factor_authentication_token, unique: true
  end
end
