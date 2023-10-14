# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create] #会員登録してないと他のページが開けない
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

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def sign_out
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:notice] = "ゲストユーザーとしてログインしました。"
    redirect_to root_path
  end



  def reject_user
    @end_user = User.find_by(email: params[:user][:email]) #ログインした時のアドレスのユーザーが存在しているか探す
    if @end_user
      if @end_user.valid_password?(params[:email][:password]) && (@end_user.is_active == false) #入力されたパスワードが一致しているか
        flash[:notice] = "退会済みです。サイドご登録をしてご利用してください"
        redirect_to new_user_registration_path
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
      redirect_to new_user_registration_path
    end
  end

end
