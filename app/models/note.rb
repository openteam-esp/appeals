# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  public     :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Note < ActiveRecord::Base
  belongs_to :appeal
  attr_accessible :appeal_id, :public

  after_create :note_appeal

  private
    def note_appeal
      self.appeal.to_note!
    end
end
