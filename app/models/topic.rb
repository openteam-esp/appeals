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

class Topic < ActiveRecord::Base
  belongs_to :section
  attr_accessible :title, :section_id

  validates_presence_of :title

  def to_s
    title
  end
end

