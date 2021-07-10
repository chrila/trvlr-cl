# frozen_string_literal: true

class AddSequenceToSegment < ActiveRecord::Migration[6.1]
  def change
    add_column :segments, :sequence, :integer, default: 0
  end
end
