class AddFieldsToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :name, :string
    add_column :appeals, :surname, :string
    add_column :appeals, :patronymic, :string
    add_column :appeals, :topic, :reference
    add_column :appeals, :email, :string
    add_column :appeals, :address_id, :integer
    add_column :appeals, :phone, :string
    add_column :appeals, :text, :text
    add_column :appeals, :public, :boolean
  end
end
