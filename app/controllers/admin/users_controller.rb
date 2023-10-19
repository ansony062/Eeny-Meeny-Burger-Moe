class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "会員情報の編集に成功しました。"
      redirect_to admin_user_path
    else
      flash.now[:notice] = "会員情報の編集に失敗しました。"
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:id, :last_name, :first_name, :last_name_kana, :first_name_kana, :nickname, :email, :encrypted_password, :is_active)
  end

end
