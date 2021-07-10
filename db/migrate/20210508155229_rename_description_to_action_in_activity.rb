# frozen_string_literal: true

class RenameDescriptionToActionInActivity < ActiveRecord::Migration[6.1]
  def up
    rename_column :activities, :description, :action
  end

  def down
    rename_column :activities, :action, :description
  end
end
