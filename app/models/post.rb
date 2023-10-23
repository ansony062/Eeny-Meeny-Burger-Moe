class Post < ApplicationRecord

  has_one_attached :image

  has_many :bookmarks, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  belongs_to :user

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io.File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #現在サインインしているユーザーがお気に入り登録しているかどうか判断するためのメソッドです。
  #find_byでend_user_idとend_user.idが一致するbookmarksを探し、なければnilを返します。
  def find_bookmark(user)
    bookmarks.find_by(user_id: user.id)
  end

end
