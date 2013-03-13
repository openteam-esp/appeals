class Context < ActiveRecord::Base
  has_many :sections
end

class AssiciatePermissionToSection < ActiveRecord::Migration
  def up
    Permission.all.each do |p|
      c = Context.find(p.context_id)
      u = p.user
      if c.sections.any?
        c.sections.each do |s|
          u.permissions.create!(role: 'operator', context: s)
        end
      else
        u.permissions.create!(role: 'manager')
      end
      p.destroy
    end

    remove_column :sections, :context_id
    drop_table :contexts
  end

  def down
    create_table "contexts", :force => true do |t|
      t.string   "title"
      t.string   "ancestry"
      t.string   "weight"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "contexts", ["ancestry"], :name => "index_contexts_on_ancestry"
    add_index "contexts", ["weight"], :name => "index_contexts_on_weight"

    add_column :sections, :context_id, :integer
    add_index :sections, :context_id

  end

end
