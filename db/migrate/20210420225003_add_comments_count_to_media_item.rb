# frozen_string_literal: true

class AddCommentsCountToMediaItem < ActiveRecord::Migration[6.1]
  def change
    add_column :media_items, :comments_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE media_items SET comments_count = (
        SELECT COUNT(1)
          FROM comments
         WHERE commentable_type = 'MediaItem' AND commentable_id = media_items.id)
    SQL
  end
end
