class Note < ActiveRecord::Base
  belongs_to :appeal

  after_create :note_appeal

  private
    def note_appeal
      self.appeal.to_note!
    end
end
