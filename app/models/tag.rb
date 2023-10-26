class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates :name, presence: true, length: { minimum: 1 }

  def self.search_for(keyword)
    Tag.where("name LIKE ?", "%#{keyword}%")
  end

end
