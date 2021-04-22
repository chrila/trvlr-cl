class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy

  attr_readonly :likes_count
end
