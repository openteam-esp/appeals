class AddSectionsToUser < ActiveRecord::Migration
  def change
    add_column :users, :sections, :text
  end
end
