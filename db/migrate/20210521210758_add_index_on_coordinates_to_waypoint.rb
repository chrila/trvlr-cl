class AddIndexOnCoordinatesToWaypoint < ActiveRecord::Migration[6.1]
  def change
    add_index :waypoints, [:latitude, :longitude]
  end
end
