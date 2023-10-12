class Public::UsersController < ApplicationController
  
  def withdrawal
    @user = User.find(current_user.id)
    @user.update(is_active: false) #is_activeをfalse(退会)に変更
    reset_session
    flash[:notice] = "退会しました"
    redirect_to root_path
  end
end
