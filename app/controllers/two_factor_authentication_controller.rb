class TwoFactorAuthenticationController < ApplicationController
  def show
    @user = User.find_by(two_factor_authentication_token: params[:two_factor_authentication_token])
  end

  def update
    permit_parameters = params.permit(:user_id, :otp_attempt).to_h
    user = User.find(permit_parameters[:user_id])

    # OTPが正しければユーザーをサインイン、正しくなければ認証画面にリダイレクト
    if user.validate_and_consume_otp!(params[:otp_attempt])
      user.update(otp_required_for_login: true)
      sign_in(user)
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:alert] = '入力に誤りがあります。もう一度入力してください。'
      redirect_to two_factor_authentication_show_path(two_factor_authentication_token: user.two_factor_authentication_token)
    end
  end
end