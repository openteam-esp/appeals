class AppealSearch < Search
  attr_accessible :keywords

  column :keywords, :text
  column :state,    :string
end


# == Schema Information
#
# Table name: searches
#
#  keywords :text
#  state    :string
#

