class Post < ApplicationRecord
  belongs_to :waypoint
  belongs_to :user
  has_one :trip, through: :waypoint
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  attr_readonly :likes_count
  attr_readonly :comments_count

  scope :for_trip, ->(trip) { where(trip: trip) }
  scope :for_waypoint, ->(waypoint) { where(waypoint: waypoint) }
end
