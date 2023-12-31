class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]

  def index
    if params[:latest]
      @posts = Post.latest.page(params[:page]).per(12)
    elsif params[:old]
      @posts = Post.old.page(params[:page]).per(12)
    #elsif params[:most_favorited]
      #@posts = Post.most_favorited.page(params[:page]).per(12)
    else
      @posts = Post.order(created_at: :desc).page(params[:page]).per(12)
    end.to_a
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @tags = Tag.all
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
    @tag_list = @post.tags.pluck(:name).split('、')
  end

  def update
    @post = Post.find(params[:id])
    @tag_list = params[:post][:tags_name].split('、')
    if @post.update(post_params)
       @post.save_tags(@tag_list)
      flash[:notice] = "投稿の編集に成功しました。"
      redirect_to post_path
    else
      flash.now[:notice] = "投稿の編集に失敗しました。"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end


  private

  def post_params
    params.require(:post).permit(:user_id, :image, :name, :shop_name, :place, :review, :body)
  end

  def correct_user
    @post = Post.find(params[:id])
    @user = @post.user
    redirect_to posts_path unless @user == current_user
  end

end
