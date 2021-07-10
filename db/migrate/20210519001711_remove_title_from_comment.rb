# frozen_string_literal: true

class RemoveTitleFromComment < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :title
  end
end
