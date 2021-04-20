class AddCommentsCountToTrip < ActiveRecord::Migration[6.1]
  def change
    add_column :trips, :comments_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE trips SET comments_count = (
        SELECT COUNT(1)
          FROM comments
         WHERE commentable_type = 'Trip' AND commentable_id = trips.id)
    SQL
  end
end
