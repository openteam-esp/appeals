class CreateUploads < ActiveRecord::Migration
  def change
    create_table "uploads", :force => true do |t|
      t.integer  "appeal_id"
      t.string   "file_name"
      t.string   "file_mime_type"
      t.integer  "file_size"
      t.string   "file_uid"
      t.timestamps
    end
  end
end
