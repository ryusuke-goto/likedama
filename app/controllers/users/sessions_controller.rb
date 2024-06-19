# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super do |user|
      if user.persisted?
        # ユーザーが正常に作成された場合
        @buff = user.login_buff
      end
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    user = User.guest
    @buff = user.guest_buff
    sign_in user
    redirect_to diaries_path, notice: "ゲストユーザーとしてログインしました。"
  end

  #ログイン後のリダイレクト先
  def after_sign_in_path_for(resource)
    diaries_path
  end 
  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
