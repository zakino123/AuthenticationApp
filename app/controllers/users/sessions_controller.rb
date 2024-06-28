class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super do |resource|
      # ログインに成功したら、ワンタイムパスワードを生成して、保存する
      if resource.persisted?
        resource.two_factor_authentication_token = SecureRandom.hex(20)
        resource.save!
        session[:two_factor_user_id] = resource.id
        session[:two_factor_expires_at] = 3.minutes.from_now
        sign_out resource

        # ログイン成功後にワンタイムパスワード画面にメールを送信
        otp = resource.otp_code
        UserMailer.otp_email(resource, otp).deliver_now

        # ワンタイムパスワードを入力できる認証画面に遷移
        redirect_to two_factor_authentication_show_path and return
      end
    end
  end

  def destroy
    super
  end
end
