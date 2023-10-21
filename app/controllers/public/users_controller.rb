class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "会員情報を変更しました。"
      redirect_to users_mypage_path
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
    params.require(:user).permit(:image, :last_name, :first_name, :last_name_kana, :first_name, :nickname, :email)
  end

end
