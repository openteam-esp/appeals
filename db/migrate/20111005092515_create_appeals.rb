class CreateAppeals < ActiveRecord::Migration
  def change
    create_table :appeals do |t|
      t.string :surname
      t.string :name
      t.string :patronymic
      t.integer :topic_id
      t.string :email
      t.string :phone
      t.text :text
      t.boolean :public
      t.string :answer_kind

      t.timestamps
    end
  end
end
