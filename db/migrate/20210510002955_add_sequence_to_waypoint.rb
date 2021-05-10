class AddSequenceToWaypoint < ActiveRecord::Migration[6.1]
  def change
    add_column :waypoints, :sequence, :integer, default: 0
  end
end
