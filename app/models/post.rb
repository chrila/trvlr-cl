# frozen_string_literal: true

class Post < ApplicationRecord
  include ActivitySubject
  include Likeable

  belongs_to :waypoint
  belongs_to :user
  has_one :trip, through: :waypoint
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy

  has_rich_text :content

  attr_readonly :likes_count
  attr_readonly :comments_count

  scope :created_between, ->(date_from, date_to) { where("created_at between ? and ?", date_from, date_to) }
  scope :most_popular_public, lambda {
    joins(:waypoint)
      .joins(:trip)
      .where("trips.visibility = ?", Trip.visibilities["visibility_public"])
      .order(likes_count: :desc, comments_count: :desc)
  }

  validates :title, presence: true
  validates :content, presence: true

  def activity_string
    "a blog post"
  end
end
