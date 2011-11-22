class AddSectionIdToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :section_id, :integer
  end
end
