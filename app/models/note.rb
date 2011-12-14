class Note < ActiveRecord::Base
  belongs_to :appeal

  after_create :note_appeal

  private
    def note_appeal
      self.appeal.to_note!
    end
end
# == Schema Information
#
# Table name: notes
#
#  id         :integer         not null, primary key
#  public     :boolean
#  appeal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

