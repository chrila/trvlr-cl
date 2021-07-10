# frozen_string_literal: true

class AddFollowingCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :following_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE users SET following_count = (
        SELECT COUNT(1)
          FROM followings
         WHERE user_id = users.id)
    SQL
  end
end
