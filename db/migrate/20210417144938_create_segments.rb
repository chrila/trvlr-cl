# frozen_string_literal: true

class CreateSegments < ActiveRecord::Migration[6.1]
  def change
    create_table :segments do |t|
      t.belongs_to :trip, null: false, foreign_key: true
      t.belongs_to :waypoint_from, null: false, foreign_key: { to_table: "waypoints" }
      t.belongs_to :waypoint_to, null: false, foreign_key: { to_table: "waypoints" }
      t.datetime :time_from
      t.datetime :time_to
      t.float :distance
      t.integer :status

      t.timestamps
    end
  end
end
