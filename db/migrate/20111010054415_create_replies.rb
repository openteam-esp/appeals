class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :number
      t.date :replied_on
      t.text :text
      t.boolean :public
      t.string :replied_by
      t.references :appeal

      t.timestamps
    end
  end
end
