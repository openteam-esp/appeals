class AddKremlinRegisteredOnToAppeals < ActiveRecord::Migration
  def change
    add_column :appeals, :kremlin_registered_on, :date
  end
end
