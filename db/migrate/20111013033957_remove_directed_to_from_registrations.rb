class RemoveDirectedToFromRegistrations < ActiveRecord::Migration
  def up
    remove_column :registrations, :directed_to
  end

  def down
    add_column :registrations, :directed_to, :string
  end
end
