class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  def self.liked?(user, likeable)
    where(user: user, likeable: likeable).count.positive?
  end

  def self.like(user, likeable)
    create(user: user, likeable: likeable)
  end

  def self.dislike(user, likeable)
    entry = find_by(user: user, likeable: likeable)
    entry&.destroy
  end
end
