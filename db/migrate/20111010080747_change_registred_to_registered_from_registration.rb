class ChangeRegistredToRegisteredFromRegistration < ActiveRecord::Migration
  def change
    rename_column :registrations, :registred_on, :registered_on
  end
end
