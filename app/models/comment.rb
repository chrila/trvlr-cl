class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: true
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :activities, as: :subject, dependent: :destroy

  attr_readonly :likes_count

  scope :created_between, ->(date_from, date_to) { where('created_at between ? and ?', date_from, date_to).order(id: :desc) }
end
