class TwoFactorAuthenticationController < ApplicationController
  before_action :validate_two_factor_session, only: [:show, :update]

  def show
    @user = User.find(session[:two_factor_user_id])
  end

  def update
    permit_parameters = params.permit(:user_id, :otp).to_h
    user = User.find(session[:two_factor_user_id])

    # OTPが正しければユーザーをサインイン、正しくなければ認証画面にリダイレクト
    if user.authenticate_otp(permit_parameters[:otp], drift: 60)
      sign_in(user)
      clear_two_factor_session
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:alert] = '入力に誤りがあります。もう一度入力してください。'
      redirect_to two_factor_authentication_show_path
    end
  end

  private

  def validate_two_factor_session
    if session[:two_factor_user_id].nil? || session[:two_factor_expires_at].nil? || session[:two_factor_expires_at] < Time.zone.now
      clear_two_factor_session
      redirect_to new_user_session_path, alert: 'セッションが無効です。再度ログインしてください'
    end
  end

  def clear_two_factor_session
    session.delete(:two_factor_user_id)
    session.delete(:two_factor_expires_at)
  end
end
