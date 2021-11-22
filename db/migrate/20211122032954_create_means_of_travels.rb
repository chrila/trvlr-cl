class CreateMeansOfTravels < ActiveRecord::Migration[6.1]
  def change
    create_table :means_of_travels do |t|
      t.string :name
      t.string :icon

      t.timestamps
    end
  end
end
