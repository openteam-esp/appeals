class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.references  :appeal
      t.date        :registred_on
      t.string      :number
      t.timestamps
    end
    add_index :registrations, :appeal_id
  end
end
