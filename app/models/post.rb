class Post < ApplicationRecord
  belongs_to :waypoint
  has_many :comments, as: :commentable
end
