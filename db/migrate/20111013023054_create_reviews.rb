class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :recipient
      t.references :appeal

      t.timestamps
    end
    add_index :reviews, :appeal_id
  end
end
