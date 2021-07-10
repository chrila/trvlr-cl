# frozen_string_literal: true

class AddLikesCountToMediaItem < ActiveRecord::Migration[6.1]
  def change
    add_column :media_items, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE media_items SET likes_count = (
        SELECT COUNT(1)
          FROM likes
         WHERE likeable_type = 'MediaItem' AND likeable_id = media_items.id)
    SQL
  end
end
