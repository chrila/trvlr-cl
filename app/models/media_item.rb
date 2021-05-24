class MediaItem < ApplicationRecord
  include ActivitySubject
  include Likeable

  belongs_to :waypoint
  belongs_to :user
  has_one :trip, through: :waypoint
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy

  has_one_attached :photo

  attr_readonly :likes_count
  attr_readonly :comments_count

  scope :for_trip, ->(trip) { where(waypoint: trip.waypoints).order(id: :desc) }
  scope :for_waypoint, ->(waypoint) { where(waypoint: waypoint).order(id: :desc) }
  scope :created_between, ->(date_from, date_to) { where('created_at between ? and ?', date_from, date_to) }
  scope :most_popular, -> { order(likes_count: :desc, comments_count: :desc) }

  validates :title, presence: true
  validates :description, presence: true

  def activity_string
    'a media item'
  end
end
