class AddCommentsCountToActivity < ActiveRecord::Migration[6.1]
  def change
    add_column :activities, :comments_count, :integer, default: 0, null: false

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
      UPDATE activities SET comments_count = (
        SELECT COUNT(1)
          FROM comments
         WHERE commentable_type = 'Activity' AND commentable_id = activities.id)
    SQL
  end
end
