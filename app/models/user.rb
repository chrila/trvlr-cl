class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :trip_users
  has_many :trips, through: :trip_users
  has_many :followings_passive, class_name: 'Following', foreign_key: :followed_user_id
  has_many :followers, class_name: 'User', through: :followings_passive, source: :user
  has_many :followings_active, class_name: 'Following', foreign_key: :user_id
  has_many :following, class_name: 'User', through: :followings_active, source: :followed_user
end
