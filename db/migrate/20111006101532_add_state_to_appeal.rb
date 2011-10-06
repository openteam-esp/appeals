class AddStateToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :state, :string
  end
end
