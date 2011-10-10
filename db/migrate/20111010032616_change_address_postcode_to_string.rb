class ChangeAddressPostcodeToString < ActiveRecord::Migration
  def change
    change_column :addresses, :postcode, :string
  end
end
