class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references  :appeal
      t.string      :recipient
      t.timestamps
    end
    add_index :reviews, :appeal_id
  end
end
