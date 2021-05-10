class Segment < ApplicationRecord
  belongs_to :trip
  belongs_to :waypoint_from, class_name: 'Waypoint'
  belongs_to :waypoint_to, class_name: 'Waypoint'

  after_create :set_sequence

  enum status: %i[segment_open segment_active segment_finished]

  scope :finished_between, lambda { |date_from, date_to|
    segment_finished.where('segments.time_to between ? and ?', date_from, date_to)
  }

  def increase_sequence
    sg_after = trip.segments.find_by(sequence: sequence + 1)
    return unless sg_after

    sg_after.update(sequence: sg_after.sequence - 1)
    update(sequence: sequence + 1)
  end

  def decrease_sequence
    return if sequence == 1

    sg_before = trip.segments.find_by(sequence: sequence - 1)
    sg_before.update(sequence: sg_before.sequence + 1)
    update(sequence: sequence - 1)
  end

  def first?
    !trip.segments.find_by(sequence: sequence - 1).present?
  end

  def last?
    !trip.segments.find_by(sequence: sequence + 1).present?
  end

  def status_string
    status.split('_').last.humanize
  end

  private

  def set_sequence
    update(sequence: (trip.segments.maximum(:sequence) || 0) + 1)
  end
end
