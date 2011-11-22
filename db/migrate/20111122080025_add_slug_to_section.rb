class AddSlugToSection < ActiveRecord::Migration
  def change
    add_column :sections, :slug, :string
  end
end
