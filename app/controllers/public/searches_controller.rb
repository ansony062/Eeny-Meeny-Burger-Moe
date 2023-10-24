class Public::SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]

    if @keyword == "user"
      @records = User.search_for(@keyword)
    elsif @keyword == "post"
      @records = Post.search_for(@keyword)
    elsif @keyword == "tag"
      @records = Tag.search_for(@keyword)
    end
  end

end
