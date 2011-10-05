class CreateAppeals < ActiveRecord::Migration
  def change
    create_table :appeals do |t|
      t.string :surname

      t.timestamps
    end
  end
end
