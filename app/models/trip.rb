class Trip < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :waypoints
  has_many :trip_users
  has_many :users, through: :trip_users

  enum status: %i[trip_draft trip_active trip_finished trip_cancelled]
  enum visibility: %i[visibility_private visibility_users_only visibility_public]

  scope :public_newest, -> { visibility_public.order(:id).reverse.first(10) }
  scope :public_most_likes, -> { visibility_public.order(:likes_count).reverse.first(10) }
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
