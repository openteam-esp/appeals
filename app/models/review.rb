class Review < ActiveRecord::Base
  belongs_to :appeal

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
#  recipient  :string(255)
#  appeal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

