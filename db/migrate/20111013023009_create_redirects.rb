class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :recipient
      t.references :appeal

      t.timestamps
    end
    add_index :redirects, :appeal_id
  end
end
