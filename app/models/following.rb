class Following < ApplicationRecord
  belongs_to :user, counter_cache: :following_count
  belongs_to :followed_user, class_name: 'User'
end
