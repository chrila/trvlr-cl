class Trip < ApplicationRecord
  include ActivitySubject
  include Likeable

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy
  has_many :waypoints, dependent: :destroy
  has_many :segments, dependent: :destroy
  has_many :trip_users, dependent: :destroy
  has_many :users, through: :trip_users

  enum status: %i[trip_draft trip_active trip_finished trip_cancelled]
  enum visibility: %i[visibility_private visibility_users visibility_public]

  scope :public_newest, -> { visibility_public.order(id: :desc).first(10) }
  scope :public_most_likes, -> { visibility_public.order(likes_count: :desc).first(10) }
  scope :public_top_three, -> { public_most_likes.first(3) }
  scope :of_user, ->(user) { joins(:trip_users).where('user_id = ?', user.id).order('trips.id DESC') }

  attr_readonly :likes_count
  attr_readonly :comments_count

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :budget, presence: true
  validates :visibility, presence: true, inclusion: { in: Trip.visibilities, message: 'is invalid' }
  validates :status, presence: true, inclusion: { in: Trip.statuses, message: 'is invalid' }

  def visibility_string
    visibility.split('_').last.humanize
  end

  def status_string
    status.split('_').last.humanize
  end

  def owned_by?(a_user)
    users.exists? a_user.id
  end

  def activity_string
    'a trip'
  end
end
