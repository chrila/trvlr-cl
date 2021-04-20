class AddLikesCountToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :likes_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE trips SET likes_count = (
        SELECT COUNT(1)
          FROM likes
         WHERE likeable_type = 'Trip' AND likeable_id = trips.id)
    SQL
  end
end
