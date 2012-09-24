class AddKremlinNumberToAppeals < ActiveRecord::Migration
  def change
    add_column :appeals, :kremlin_number, :string
  end
end
