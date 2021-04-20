class AddLikesCountToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE posts SET likes_count = (
        SELECT COUNT(1)
          FROM likes
         WHERE likeable_type = 'Post' AND likeable_id = posts.id)
    SQL
  end
end
