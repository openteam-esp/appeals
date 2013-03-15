# == Schema Information
#
# Table name: sections
#
#  id         :integer          not null, primary key
#  context_id :integer
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:section) do
  title 'Section title'
end

