class Trip < ApplicationRecord
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :waypoints, dependent: :destroy
  has_many :segments, dependent: :destroy
  has_many :trip_users, dependent: :destroy
  has_many :users, through: :trip_users

  enum status: %i[trip_draft trip_active trip_finished trip_cancelled]
  enum visibility: %i[visibility_private visibility_users visibility_public]

  scope :public_newest, -> { visibility_public.order(:id).reverse.first(10) }
  scope :public_most_likes, -> { visibility_public.order(:likes_count).reverse.first(10) }
  scope :public_top_three, -> { public_most_likes.first(3) }
  scope :of_user, ->(user) { joins(:trip_users).where('user_id = ?', user.id).order('trips.id DESC') }

  attr_readonly :likes_count
  attr_readonly :comments_count

  def visibility_string
    visibility.split('_').last.humanize
  end

  def status_string
    status.split('_').last.humanize
  end
end
