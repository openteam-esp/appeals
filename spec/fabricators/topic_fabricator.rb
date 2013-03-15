# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  section_id :integer
#  title      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'forgery'

Fabricator(:topic) do
  title { Forgery(:lorem_ipsum).words(2) }
end

