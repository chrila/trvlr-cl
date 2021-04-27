class MediaItem < ApplicationRecord
  belongs_to :waypoint
  belongs_to :user
  has_one :trip, through: :waypoint
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  has_one_attached :photo

  attr_readonly :likes_count
  attr_readonly :comments_count

  scope :for_trip, ->(trip) { where(waypoint: trip.waypoints) }
  scope :for_waypoint, ->(waypoint) { where(waypoint: waypoint) }
end
