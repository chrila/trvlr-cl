# frozen_string_literal: true

class AddLikesCountToActivity < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE activities SET likes_count = (
        SELECT COUNT(1)
          FROM likes
         WHERE likeable_type = 'Activity' AND likeable_id = activities.id)
    SQL
  end
end
