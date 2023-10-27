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
      @om = (@tag.to_a)[0].id                   #キーワードのあるタグのidを取得
      @post_tag = PostTag.where(tag_id: @om)    #post_tagからすべてのキーワードのあるタグのidを取得
      @mapost = @post_tag.to_a.map(&:post_id)   #タグidのついた投稿のidを取得
      @post = Post.where(id: @mapost)           #タグのついた投稿のidをすべて取得
      @records = @post.to_a                     #投稿を取得
    end
  end

end
