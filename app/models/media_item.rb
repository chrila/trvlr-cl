class MediaItem < ApplicationRecord
  belongs_to :post
  has_many :comments, as: :commentable
end
