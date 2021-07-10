# frozen_string_literal: true

class CreateWaypoints < ActiveRecord::Migration[6.1]
  def change
    create_table :waypoints do |t|
      t.belongs_to :trip, null: false, foreign_key: true
      t.string :name
      t.text :notes
      t.string :address
      t.string :country
      t.string :continent
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
