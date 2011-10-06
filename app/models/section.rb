class Section < ActiveRecord::Base
  has_many :topics

  validates_presence_of :title
end
