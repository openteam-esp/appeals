class ChangeUserFieldsTypeToTextInAppeals < ActiveRecord::Migration
  def up
    change_column :appeals, :user_agent, :text,     :limit => nil
    change_column :appeals, :user_referrer, :text,  :limit => nil
  end
end
