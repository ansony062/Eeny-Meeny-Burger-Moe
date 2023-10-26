class Public::SearchesController < ApplicationController

  def search
    #byebug
    @keyword = params[:keyword]
    @model = params[:model]

    if @model == "user"
      @records = User.search_for(@keyword)
    elsif @model == "post"
      @records = Post.search_for(@keyword)
    elsif @model == "tag"
      @tag = Tag.search_for(@keyword)
      @om = (@tag.to_a)[0].id
      @post_tag = PostTag.where(tag_id: @om)
      @mapost = @post_tag.to_a.map(&:post_id)
      @post = Post.where(id: @mapost)
      @records = @post.to_a
    end
  end

end
