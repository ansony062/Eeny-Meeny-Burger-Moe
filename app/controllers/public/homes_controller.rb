class Public::HomesController < ApplicationController

  def top
    @posts = Post.all.last(3)
    @tags = Tag.all
  end
end
