class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  def self.search_for(keyword)
    if Tag.where('name LIKE ?', '%#{keyword}%')
    end
  end

end
