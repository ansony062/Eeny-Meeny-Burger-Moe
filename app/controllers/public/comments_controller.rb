class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.save
  end

  def destroy
    @comment = Comment.find(parmas[:id]).destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:post_comment)
  end

end
