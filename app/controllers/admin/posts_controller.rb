class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!


  def index
    @posts = Post.page(params[:page]).per(12)
  end

  def show
    @post = Post.find(params[:id])
    @tags = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の編集に成功しました。"
      redirect_to admin_post_path
    else
      flash.now[:notice] = "投稿の編集に失敗しました。"
      render 'edit'
    end
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :image, :name, :shop_name, :place, :review, :body)
  end

end
