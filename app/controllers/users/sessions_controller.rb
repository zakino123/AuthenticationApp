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
        sign_out resource

        # ログイン成功後にワンタイムパスワードが載ったメールを送信
        resource.email_otp

        # ワンタイムパスワードを入力できる認証画面に遷移
        redirect_to two_factor_authentication_show_path(two_factor_authentication_token: resource.two_factor_authentication_token) and return
      end
    end
  end

  def destroy
    super
  end
end
