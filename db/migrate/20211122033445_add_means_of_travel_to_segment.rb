class AddMeansOfTravelToSegment < ActiveRecord::Migration[6.1]
  def change
    add_reference :segments, :means_of_travel, null: true, foreign_key: true
  end
end
