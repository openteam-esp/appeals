class AddDeletedAtAndDeletedByToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :deleted_at, :datetime
    add_column :appeals, :deleted_by_id, :integer
  end
end
