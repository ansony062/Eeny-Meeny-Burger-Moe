class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @posts = Post.page(params[:page]).per(12)
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @tags = Tag.all
    @tag_list = @post.tags.pluck(:name).join('、')
    @post_tags = @post.tags
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @tag_list = @post.tags.pluck(:name).join('、')
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag_list = params[:post][:tags_name].split('、') #文字列を取得、コンマで分割して格納

    if @post.save
      @post.save_tags(@tag_list)
      flash[:notice] = "投稿しました！"
      redirect_to posts_path
    else
      flash.now[:notice] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    @tag_list = params[:post][:tags_name].split('、')
  end

  def update
    @post = Post.find(params[:id])
    @tag_list = params[:post][:tags_name].split('、')
    if @post.update(post_params)
       @post.save_tags(@tag_list)
      flash[:notice] = "投稿の編集に成功しました。"
      redirect_to posts_path
    else
      flash.now[:notice] = "投稿の編集に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :image, :name, :shop_name, :place, :review, :body)
  end

end
