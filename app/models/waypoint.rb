class Waypoint < ApplicationRecord
  include Sequencable

  belongs_to :trip
  has_many :segments_starting, class_name: 'Segment', foreign_key: 'waypoint_from_id', dependent: :destroy
  has_many :segments_ending, class_name: 'Segment', foreign_key: 'waypoint_to_id', dependent: :destroy
  has_many :media_items, dependent: :destroy

  after_create :init_sequence

  def lat_long_str
    "#{latitude}, #{longitude}"
  end

  def seq_name_str
    "#{sequence} - #{name}"
  end

  private

  def data_collection
    trip.waypoints
  end
end
