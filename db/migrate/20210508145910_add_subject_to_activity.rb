class AddSubjectToActivity < ActiveRecord::Migration[6.1]
  def change
    add_reference :activities, :subject, polymorphic: true, null: false
  end
end
