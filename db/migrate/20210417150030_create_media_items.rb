# frozen_string_literal: true

class CreateMediaItems < ActiveRecord::Migration[6.1]
  def change
    create_table :media_items do |t|
      t.belongs_to :post, null: false, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
