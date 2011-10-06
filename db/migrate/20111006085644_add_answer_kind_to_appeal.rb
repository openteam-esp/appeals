class AddAnswerKindToAppeal < ActiveRecord::Migration
  def change
    add_column :appeals, :answer_kind, :string
  end
end
