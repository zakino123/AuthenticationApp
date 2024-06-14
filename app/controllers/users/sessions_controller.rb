class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super do |resource|
      # ログインに成功したら、ワンタイムパスワードを生成して、保存する
      if resource.persisted?
        resource.two_factor_authentication_token = SecureRandom.hex(20)
        resource.otp_secret = User.generate_otp_secret
        resource.otp_required_for_login = true
        resource.save!
        sign_out resource

        # ログイン成功後にワンタイムパスワード画面にメールを送信
        otp = resource.current_otp
        UserMailer.otp_email(resource, otp).deliver_now

        # ワンタイムパスワードを入力できる認証画面に遷移
        redirect_to two_factor_authentication_show_path(two_factor_authentication_token: resource.two_factor_authentication_token) and return
      end
    end
  end

  def destroy
    super
  end
end