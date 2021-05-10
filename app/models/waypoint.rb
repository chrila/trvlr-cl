class Waypoint < ApplicationRecord
  belongs_to :trip
  has_many :segments_starting, class_name: 'Segment', foreign_key: 'waypoint_from_id', dependent: :destroy
  has_many :segments_ending, class_name: 'Segment', foreign_key: 'waypoint_to_id', dependent: :destroy
  has_many :media_items, dependent: :destroy

  after_create :set_sequence

  def set_sequence
    self.sequence = (trip.waypoints.maximum(:sequence) || 0) + 1
  end

  def increase_sequence
    wp_after = trip.waypoints.find_by(sequence: sequence + 1)
    return unless wp_after

    wp_after.update(sequence: wp_after.sequence - 1)
    update(sequence: sequence + 1)
  end

  def decrease_sequence
    return if sequence == 1

    wp_before = trip.waypoints.find_by(sequence: sequence - 1)
    wp_before.update(sequence: wp_before.sequence + 1)
    update(sequence: sequence - 1)
  end

  def lat_long_str
    "#{latitude}, #{longitude}"
  end

  def seq_name_str
    "#{sequence} - #{name}"
  end
end
