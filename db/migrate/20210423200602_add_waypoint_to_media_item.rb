class AddWaypointToMediaItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :media_items, :waypoint, null: true, foreign_key: true
  end
end
