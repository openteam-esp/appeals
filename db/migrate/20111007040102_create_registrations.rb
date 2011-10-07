class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.date :registred_on
      t.string :number
      t.string :directed_to
      t.references :appeal

      t.timestamps
    end
    add_index :registrations, :appeal_id
  end
end
