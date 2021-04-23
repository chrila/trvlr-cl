class MediaItem < ApplicationRecord
  belongs_to :waypoint
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  attr_readonly :likes_count
  attr_readonly :comments_count
end
