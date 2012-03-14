class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.references  :appeal
      t.string      :recipient
      t.timestamps
    end
    add_index :redirects, :appeal_id
  end
end
