class Users::SessionsController < Devise::SessionsController
  def new
    super
  end

  def create
    super do |resource|
      # ログインに成功したら、ワンタイムパスワードを生成して、保存する
      if resource.persisted?
        # ログイン成功後にワンタイムパスワード画面にメールを送信
        otp = resource.otp_code
        UserMailer.otp_email(resource, otp).deliver_now
        sign_out current_user

        # ワンタイムパスワードを入力できる認証画面に遷移
        redirect_to two_factor_authentication_show_path, flash: { user_id: resource.id }
        return
      end
    end
  end

  def destroy
    super
  end
end
