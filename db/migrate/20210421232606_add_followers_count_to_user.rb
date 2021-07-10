# frozen_string_literal: true

class AddFollowersCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :followers_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE users SET followers_count = (
        SELECT COUNT(1)
          FROM followings
         WHERE followed_user_id = users.id)
    SQL
  end
end
