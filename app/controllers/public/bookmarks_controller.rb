class Public::BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @bookmarks = current_user.bookmarks
  end

  def create
    post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.new(post_id: post.id)
    @bookmark.post_id = post.id
    @bookmark.save
  end

  def destroy
    post = Post.find(params[:post_id])
    @bookmark = current_user.bookmarks.find_by(post_id: post.id)
    @bookmark.destroy
  end


end
