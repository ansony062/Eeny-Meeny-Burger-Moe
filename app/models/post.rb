class Post < ApplicationRecord

  has_many :bookmarks, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  belongs_to :user
end
