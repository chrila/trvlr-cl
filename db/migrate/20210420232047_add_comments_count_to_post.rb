# frozen_string_literal: true

class AddCommentsCountToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :comments_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE posts SET comments_count = (
        SELECT COUNT(1)
          FROM comments
         WHERE commentable_type = 'Post' AND commentable_id = posts.id)
    SQL
  end
end
