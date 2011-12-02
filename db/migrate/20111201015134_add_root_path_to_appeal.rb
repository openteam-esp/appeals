class AddRootPathToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :root_path, :string
  end
end
