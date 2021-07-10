# frozen_string_literal: true

class AddCoverPhotoToTrip < ActiveRecord::Migration[6.1]
  def change
    add_reference :trips, :cover_photo, null: true, foreign_key: { to_table: "media_items" }
  end
end
