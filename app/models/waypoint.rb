class Waypoint < ApplicationRecord
  belongs_to :trip
  has_many :segments_starting, class_name: 'Segment', foreign_key: 'waypoint_from_id', dependent: :destroy
  has_many :segments_ending, class_name: 'Segment', foreign_key: 'waypoint_to_id', dependent: :destroy
  has_many :media_items, dependent: :destroy
end
