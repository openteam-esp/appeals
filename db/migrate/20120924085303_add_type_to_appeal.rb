class AddTypeToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :type, :string
  end
end
