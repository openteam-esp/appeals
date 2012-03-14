class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references  :appeal
      t.boolean     :public
      t.date        :replied_on
      t.string      :root_path
      t.string      :number
      t.string      :replied_by
      t.text        :text
      t.timestamps
    end
  end
end
