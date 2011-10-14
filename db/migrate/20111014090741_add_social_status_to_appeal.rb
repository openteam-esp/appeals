class AddSocialStatusToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :social_status, :string
  end
end
