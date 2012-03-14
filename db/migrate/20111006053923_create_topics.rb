class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.references  :section
      t.text        :title
      t.timestamps
    end
    add_index :topics, :section_id
  end
end
