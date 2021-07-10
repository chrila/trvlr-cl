# frozen_string_literal: true

class RenameVisbilityToVisibilityInTrips < ActiveRecord::Migration[6.1]
  def up
    rename_column :trips, :visbility, :visibility
  end

  def down
    rename_column :trips, :visibility, :visbility
  end
end
