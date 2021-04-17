class Trip < ApplicationRecord
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
