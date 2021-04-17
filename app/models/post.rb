class Post < ApplicationRecord
  belongs_to :waypoint
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
