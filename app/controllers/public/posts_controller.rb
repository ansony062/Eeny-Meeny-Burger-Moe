class Public::PostsController < ApplicationController

  def index
    @posts = Post.page(params[:page]).per(12)
    @tags = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @tag_list = @post.tags.pluck(:name).join(',')
    @post_tags = @post.tags
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @tags = Tag.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @tag_list = params[:post][:name].split(',') #文字列を取得、コンマで分割して格納
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "投稿しました！"
      redirect_to posts_path
    else
      flash.now[:notice] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿の編集に成功しました。"
      redirect_to posts_path
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
