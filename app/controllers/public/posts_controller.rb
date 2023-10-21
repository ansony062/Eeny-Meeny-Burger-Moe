class Public::PostsController < ApplicationController




  private

  def post_params
    params.require(:post).permit(:user_id, :image, :name, :shop_name, :place, :review, :body)
  end

end
