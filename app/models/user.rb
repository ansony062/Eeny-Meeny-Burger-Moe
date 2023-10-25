class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image

  has_many :posts,     dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_posts, through: :bookmarks, source: :post
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy   #フォローしている関連付け
  has_many :followers, through: :reverse_of_relationships, source: :follower                                        #フォロワーを取得
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy              #フォローしている関連付け
  has_many :followings, through: :relationships, source: :followed                                                  #フォローしているユーザーを取得


  def full_name
    last_name + ' ' + first_name
  end

  def full_name_kana
    last_name_kana + ' ' + first_name_kana
  end


  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user| #指定した条件で探して、存在すればそのデータを返し、存在しなければ新しいデータを作成する
      user.password = SecureRandom.urlsafe_base64
      user.last_name = "ゲスト"
      user.first_name = "太郎"
      user.last_name_kana = "ゲスト"
      user.first_name_kana = "タロウ"
      user.nickname = "ゲスト"
      user.is_active = true
    end
  end


  def get_profile_image(wigth, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [wigth, height]).processed
  end


  #指定したユーザーをフォローする
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  #指定したユーザーのフォローを解除
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  #指定したユーザーをフォローしているか？
  def following?(user)
    followings.include?(user)
  end


  #ブックマークに追加
  def bookmark(post)
    bookmark_posts << post
  end

  #ブックマークを外す
  def unbookmark(post)
    bookmark_posts.destroy(post)
  end

  #ブックマークしているか？
  def bookmark?(post)
    bookmark_posts.include?(post)
  end

  def self.search_for(keyword)
    User.where("nickname LIKE ?", "%#{keyword}%")
  end


end
