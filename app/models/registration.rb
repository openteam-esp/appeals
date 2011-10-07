class Registration < ActiveRecord::Base
  belongs_to :appeal

  validates_presence_of :number, :registred_on

  after_create :register_appeal

  private
    def register_appeal
      self.appeal.register!
    end
end
