# frozen_string_literal: true

class AddLikesCountToComment < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE comments SET likes_count = (
        SELECT COUNT(1)
          FROM likes
         WHERE likeable_type = 'Comment' AND likeable_id = comments.id)
    SQL
  end
end
