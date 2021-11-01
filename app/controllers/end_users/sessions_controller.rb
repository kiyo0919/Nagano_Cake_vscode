# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  def after_sign_in_path_for(resource)
    customers_path
  end

  def after_sign_out_path_for(resource)
    new_end_user_session_path
  end

  # 退会済みユーザーのログイン拒否
  def reject_inactive_user
    @user = EndUser.find_by(email: params[:end_user][:email].downcase)
    if @user.is_valid
      flash[:notice] = "新規会員登録をお願いします。"
      redirect_to new_end_user_session_path
    end
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
