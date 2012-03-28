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
#  appeal_id  :integer
#  recipient  :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

