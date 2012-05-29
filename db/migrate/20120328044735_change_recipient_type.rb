class ChangeRecipientType < ActiveRecord::Migration
  def up
    change_column :redirects, :recipient, :text, :limit => nil
    change_column :reviews, :recipient, :text, :limit => nil
  end

  def down
    change_column :reviews, :recipient, :string
    change_column :redirects, :recipient, :string
  end
end
