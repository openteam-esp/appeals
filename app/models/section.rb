class Section < ActiveRecord::Base
  has_many :topics
  has_many :appeals

  validates_presence_of :title, :context

  def absolute_depth
    context.depth + 1
  end

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

