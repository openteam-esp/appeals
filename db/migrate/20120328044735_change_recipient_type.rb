class ChangeRecipientType < ActiveRecord::Migration
  def up
    change_column :redirects, :recipient, :text
    change_column :reviews, :recipient, :text
  end

  def down
    change_column :reviews, :recipient, :string
    change_column :redirects, :recipient, :string
  end
end
