class Review < ActiveRecord::Base
  belongs_to :appeal

  attr_accessible :appeal_id, :recipient

  validates_presence_of :recipient

  after_create :review_appeal

  private
    def review_appeal
      self.appeal.to_review!
    end
end
# == Schema Information
#
# Table name: reviews
#
#  id         :integer         not null, primary key
#  appeal_id  :integer
#  recipient  :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

