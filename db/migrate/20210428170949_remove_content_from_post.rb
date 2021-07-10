# frozen_string_literal: true

class RemoveContentFromPost < ActiveRecord::Migration[6.1]
  def up
    remove_column :posts, :content
  end
end
