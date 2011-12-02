class AddRootPathToReply < ActiveRecord::Migration
  def change
    add_column :replies, :root_path, :string
  end
end
