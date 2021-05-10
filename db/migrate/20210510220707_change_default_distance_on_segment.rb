class ChangeDefaultDistanceOnSegment < ActiveRecord::Migration[6.1]
  def change
    change_column_default(:segments, :distance, from: nil, to: 0)
  end
end
