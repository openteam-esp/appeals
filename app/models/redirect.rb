class Redirect < ActiveRecord::Base
  belongs_to :appeal

  validates_presence_of :recipient

  after_create :redirect_appeal

  private
    def redirect_appeal
      self.appeal.to_redirect!
    end
end
# == Schema Information
#
# Table name: redirects
#
#  id         :integer         not null, primary key
#  recipient  :string(255)
#  appeal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

