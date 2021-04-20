class MediaItem < ApplicationRecord
  belongs_to :post
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  attr_readonly :likes_count
end
