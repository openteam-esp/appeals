class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.boolean :public
      t.references :appeal

      t.timestamps
    end
    add_index :notes, :appeal_id
  end
end
