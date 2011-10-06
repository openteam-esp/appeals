class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :title
      t.references :section

      t.timestamps
    end
    add_index :topics, :section_id
  end
end
