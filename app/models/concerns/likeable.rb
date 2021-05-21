# frozen_string_literal: true

module Likeable
  extend ActiveSupport::Concern

  def liked_by?(user)
    Like.where(user: user, likeable: self).count.positive?
  end

  def like(user)
    Like.create(user: user, likeable: self)
    Activity.create(user: user, subject: self, action: 'likes')
  end

  def dislike(user)
    entry = Like.find_by(user: user, likeable: self)
    entry&.destroy
    Activity.where(user: user, subject: self, action: 'likes').destroy_all
  end
end
