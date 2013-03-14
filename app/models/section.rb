class Section < ActiveRecord::Base
  has_many :topics
  has_many :appeals
  attr_accessible :title

  validates_presence_of :title
end


# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  context_id :integer
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

