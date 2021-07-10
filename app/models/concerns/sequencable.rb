# frozen_string_literal: true

# Sequencable classes must have a column sequence:integer
module Sequencable
  extend ActiveSupport::Concern

  included do
    after_create :init_sequence
  end

  def first?
    !data_collection.find_by(sequence: sequence - 1).present?
  end

  def last?
    !data_collection.find_by(sequence: sequence + 1).present?
  end

  def increase_sequence
    update_sequence(sequence + 1)
  end

  def decrease_sequence
    update_sequence(sequence - 1)
  end

  def update_sequence(new_seq)
    do_sequence_update(sequence, new_seq) unless new_seq < 1 || new_seq > data_collection.maximum(:sequence)
  end

  def destroy
    # move the record to the last sequence first, then destroy it
    update_sequence(data_collection.maximum(:sequence))
    super
  end

  private
    def do_sequence_update(m, n)
      # cache sequence and ids, because the sequences will be updated in the DB as we go
      seq_ids = data_collection.pluck(:sequence, :id).to_h
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
      data_collection.find(id).update(sequence: seq_new)
    end

    def init_sequence
      update(sequence: (data_collection.maximum(:sequence) || 0) + 1)
    end
end
