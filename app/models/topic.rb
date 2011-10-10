class Topic < ActiveRecord::Base
  belongs_to :section

  validates_presence_of :title
end

# == Schema Information
#
# Table name: topics
#
#  id         :integer         not null, primary key
#  title      :text
#  section_id :integer
#  created_at :datetime
#  updated_at :datetime
#
