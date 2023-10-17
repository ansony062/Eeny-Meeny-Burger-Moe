class Public::HomesController < ApplicationController
  
  def top
    @posts = Post.all.last(12)
  end
end
