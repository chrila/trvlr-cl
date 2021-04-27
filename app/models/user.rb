class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]

  has_many :trip_users, dependent: :destroy
  has_many :trips, through: :trip_users
  has_many :media_items, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :segments, through: :trips
  has_many :waypoints, through: :trips
  has_many :followings_passive, class_name: 'Following', foreign_key: :followed_user_id, dependent: :destroy
  has_many :followers, class_name: 'User', through: :followings_passive, source: :user
  has_many :followings_active, class_name: 'Following', foreign_key: :user_id, dependent: :destroy
  has_many :following, class_name: 'User', through: :followings_active, source: :followed_user

  validates :username, presence: true

  scope :users_to_follow, ->(user) { where.not(id: user.followings_active.map(&:followed_user_id)) }

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.username = auth.info.name
      # user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def to_s
    username
  end

  def follow(other_user)
    Following.create(user: self, followed_user: other_user) unless following?(other_user)
  end

  def unfollow(other_user)
    followings_active.where(followed_user: other_user).destroy_all if following?(other_user)
  end

  def following?(other_user)
    followings_active.where(followed_user: other_user).size.positive?
  end
end
