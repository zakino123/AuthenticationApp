class TwoFactorAuthenticationController < ApplicationController
  def show
  end

  def update
    permit_parameters = params.permit(:user_id, :otp).to_h
    user = User.find(permit_parameters[:user_id])

    # OTPが正しければユーザーをサインイン、正しくなければ認証画面にリダイレクト
    if user.authenticate_otp(permit_parameters[:otp], drift: 60)
      sign_in(user)
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:alert] = '入力に誤りがあります。もう一度入力してください。'
      redirect_to two_factor_authentication_show_path
    end
  end
end
