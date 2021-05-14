class Activity < ApplicationRecord
  include ActivitySubject

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy
  belongs_to :subject, polymorphic: true
  has_many :activities, as: :subject, dependent: :destroy

  attr_readonly :likes_count
  attr_readonly :comments_count

  scope :for_user, ->(user) { where(user: user.following).order(id: :desc) }

  def activity_string
    'an activity'
  end
end
