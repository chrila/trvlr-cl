class CreateTripUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :trip_users do |t|
      t.integer :role
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :trip, null: false, foreign_key: true

      t.timestamps
    end
  end
end
