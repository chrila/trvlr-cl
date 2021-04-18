class Trip < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
  has_many :waypoints
  has_many :trip_users
  has_many :users, through: :trip_users

  enum status: %i[trip_draft trip_active trip_finished trip_cancelled]
  enum visibility: %i[visibility_private visibility_users_only visibility_public]
end
