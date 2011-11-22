class Section < ActiveRecord::Base
  has_many :topics
  has_many :appeals

  validates_presence_of :title, :slug
  validates_uniqueness_of :slug
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

