class Trip < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  enum status: %i[draft active finished cancelled]
  enum visibility: %i[private users_only public]
end
