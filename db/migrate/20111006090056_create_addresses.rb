class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :appeal
      t.integer :postcode
      t.string :region
      t.string :district
      t.string :street
      t.string :township
      t.string :house
      t.string :building
      t.string :flat

      t.timestamps
    end
  end
end
