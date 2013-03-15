# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  recipient  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

Fabricator(:review) do
  recipient "MyString"
end
