class AddTechnicalInformationToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :user_ip, :string
    add_column :appeals, :proxy_ip, :string
    add_column :appeals, :user_agent, :string
    add_column :appeals, :referrer, :string
  end
end
