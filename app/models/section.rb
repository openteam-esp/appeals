class Section < ActiveRecord::Base
  has_many :topics

  validates_presence_of :title
end

# == Schema Information
#
# Table name: sections
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#
