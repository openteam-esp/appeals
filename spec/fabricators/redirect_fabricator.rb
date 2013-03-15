# == Schema Information
#
# Table name: redirects
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  recipient  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:redirect) do
  recipient "MyString"
end
