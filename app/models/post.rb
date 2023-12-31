class Post < ApplicationRecord

  has_one_attached :image

  has_many :bookmarks, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  belongs_to :user

  validates :name, presence: true
  validates :shop_name, presence: true
  validates :place, presence: true
  validates :body, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io.File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?  #タグが存在してれば、名前を配列としてすべて取得
    old_tags = current_tags - tags                               #現在取得したタグから送られてきたタグを除いてoldtagとする
    new_tags = tags - current_tags                               #送られてきたタグから現在存在するタグを覗いてnewtagとする

    #古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    #新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end

  end

  #投稿順
  scope :latest, -> { order(created_at: :desc) } #最新順
  scope :old, -> { order(created_at: :asc) }     #古い順
  scope :most_favorited, -> { includes(:favorited_users)  #いいねしたユーザー
    .sort_by { |x| x.favorited_users.includes(:favorites).size }.reverse } #いいね順

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  #現在サインインしているユーザーがいいねしているかどうか判断するメソッド
  #find_byでend_user_idとend_user.idが一致するbookmarksを探し、なければnilを返す
  def find_bookmark(user)
    bookmarks.find_by(user_id: user.id)
  end

  def self.search_for(keyword)
    Post.where("name LIKE ?", "%#{keyword}%").or( Post.where("shop_name LIKE ?", "%#{keyword}%")).or(Post.where("place LIKE ?", "%#{keyword}%"))
  end

end
