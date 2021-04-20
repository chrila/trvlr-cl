class Activity < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  attr_readonly :likes_count
end
