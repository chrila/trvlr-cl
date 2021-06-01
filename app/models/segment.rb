class Segment < ApplicationRecord
  include Sequencable

  belongs_to :trip
  belongs_to :waypoint_from, class_name: 'Waypoint'
  belongs_to :waypoint_to, class_name: 'Waypoint'

  enum status: %i[segment_open segment_active segment_finished]

  scope :finished_between, lambda { |date_from, date_to|
    segment_finished.where('segments.time_to between ? and ?', date_from, date_to)
  }

  validates :waypoint_from, presence: true
  validates :waypoint_to, presence: true
  validates :time_from, presence: true
  validates :time_to, presence: true
  validates :status, presence: true, inclusion: { in: Segment.statuses, message: 'is invalid' }

  def status_string
    status.split('_').last.humanize
  end

  def activity_string
    'a segment'
  end

  private

  def data_collection
    trip.segments
  end
end
