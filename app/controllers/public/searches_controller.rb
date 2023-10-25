class Public::SearchesController < ApplicationController

  def search
    @keyword = params[:keyword]
    @model = params[:model]

    if @model == "user"
      @records = User.search_for(@keyword)
    elsif @model == "post"
      @records = Post.search_for(@keyword)
    elsif @model == "tag"
      @records = Tag.search_for(@keyword)
    end
  end

end
