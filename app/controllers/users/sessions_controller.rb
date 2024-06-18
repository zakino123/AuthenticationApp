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
        resource.save!
        sign_out resource

        # ログイン成功後にワンタイムパスワード画面にメールを送信
        qr_code = build_qr_code(user: resource)
        UserMailer.otp_email(resource, qr_code).deliver_now

        # ワンタイムパスワードを入力できる認証画面に遷移
        redirect_to two_factor_authentication_show_path(two_factor_authentication_token: resource.two_factor_authentication_token) and return
      end
    end
  end

  def destroy
    current_user.update(otp_required_for_login: false)
    super
  end

  private
  # QRコードを作成
  def build_qr_code(user:)
    qrcode = RQRCode::QRCode.new(user.otp_provisioning_uri(user.email, issuer: "mfa-sample"))
    qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    ).html_safe
  end
end
