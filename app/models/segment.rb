class Segment < ApplicationRecord
  belongs_to :trip
  belongs_to :waypoint_from, class_name: 'Waypoint'
  belongs_to :waypoint_to, class_name: 'Waypoint'

  enum status: %i[segment_open segment_active segment_finished]

  def status_string
    status.split('_').last.humanize
  end
end
