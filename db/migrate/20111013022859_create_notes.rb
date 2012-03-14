class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references  :appeal
      t.boolean     :public
      t.timestamps
    end
    add_index :notes, :appeal_id
  end
end
