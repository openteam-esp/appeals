class AddressReferences < ActiveRecord::Migration
  def up
    add_column :addresses, :appeal_id, :integer
    remove_column :appeals, :address_id
  end

  def down
    add_column :appeals, :address_id, :integer
    remove_column :addresses, :appeal_id
  end
end
