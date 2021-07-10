# frozen_string_literal: true

class AddUserToMediaItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :media_items, :user, null: false, foreign_key: true
  end
end
