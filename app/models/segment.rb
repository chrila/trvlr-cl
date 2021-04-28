class Segment < ApplicationRecord
  belongs_to :trip
  belongs_to :waypoint_from, class_name: 'Waypoint'
  belongs_to :waypoint_to, class_name: 'Waypoint'

  enum status: %i[segment_open segment_active segment_finished]

  scope :finished_between, ->(date_from, date_to) { segment_finished.where('segments.time_to between ? and ?', date_from, date_to) }

  def status_string
    status.split('_').last.humanize
  end
end
