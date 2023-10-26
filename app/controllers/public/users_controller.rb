class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def mypage
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to user_path
    else
      flash.now[:notice] = "会員情報の変更できませんでした。"
      render 'edit'
    end
  end

  def confirm
  end

  def withdrawal
    @user = User.find(current_user.id)
    @user.update(is_active: false) #is_activeをfalse(退会)に変更
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:profile_image, :last_name, :first_name, :last_name_kana, :first_name, :nickname, :email)
  end

end
