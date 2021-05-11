class Segment < ApplicationRecord
  include Sequencable

  belongs_to :trip
  belongs_to :waypoint_from, class_name: 'Waypoint'
  belongs_to :waypoint_to, class_name: 'Waypoint'

  after_create :init_sequence

  enum status: %i[segment_open segment_active segment_finished]

  scope :finished_between, lambda { |date_from, date_to|
    segment_finished.where('segments.time_to between ? and ?', date_from, date_to)
  }

  def status_string
    status.split('_').last.humanize
  end

  private

  def data_collection
    trip.segments
  end
end
