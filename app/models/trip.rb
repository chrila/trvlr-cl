class Trip < ApplicationRecord
  has_many :comments, as: :commentable
end
