class AddTwoFactorFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :two_factor_authentication_token, :string
    add_column :users, :otp_secret, :string
    add_column :users, :consumed_timestep, :integer
    add_column :users, :otp_required_for_login, :boolean

    add_index :users, :two_factor_authentication_token, unique: true
  end
end
