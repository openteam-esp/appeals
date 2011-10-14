class BindUploadWithAppealAndReply < ActiveRecord::Migration
  def change
    add_column :uploads, :uploadable_type, :string
    rename_column :uploads, :appeal_id, :uploadable_id
  end
end
