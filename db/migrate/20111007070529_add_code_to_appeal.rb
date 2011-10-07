class AddCodeToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :code, :string
  end
end
