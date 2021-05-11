class Segment < ApplicationRecord
  belongs_to :trip
  belongs_to :waypoint_from, class_name: 'Waypoint'
  belongs_to :waypoint_to, class_name: 'Waypoint'

  after_create :init_sequence

  enum status: %i[segment_open segment_active segment_finished]

  scope :finished_between, lambda { |date_from, date_to|
    segment_finished.where('segments.time_to between ? and ?', date_from, date_to)
  }

  def increase_sequence
    update_sequence(sequence + 1)
  end

  def decrease_sequence
    update_sequence(sequence - 1)
  end

  def update_sequence(new_seq)
    return if new_seq < 1 || new_seq > trip.segments.maximum(:sequence)

    do_sequence_update(sequence, new_seq)
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

  def do_sequence_update(m, n)
    # cache sequence and ids, because the sequences will be updated in the DB as we go
    seq_ids = trip.segments.pluck(:sequence, :id).to_h
    upper = [m, n].max
    lower = [m, n].min
    delta = upper - lower

    for i in (delta + 1).downto 1 do
      x = upper - (i % (delta + 1))
      y = upper - i + 1

      if m > n
        set_sequence(seq_ids[x], y)
      else
        set_sequence(seq_ids[y], x)
      end
    end
  end

  def set_sequence(id, seq_new)
    trip.segments.find(id).update(sequence: seq_new)
  end

  def init_sequence
    update(sequence: (trip.segments.maximum(:sequence) || 0) + 1)
  end
end
