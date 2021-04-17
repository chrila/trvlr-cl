class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.belongs_to :waypoint, null: false, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
