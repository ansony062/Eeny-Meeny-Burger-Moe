class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  
  
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

  # def active_for_authentication? #is_acttiveがfalseならtrueを返す
  #   super && (is_active == false)
  # end

end
