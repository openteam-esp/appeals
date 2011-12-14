class Registration < ActiveRecord::Base
  belongs_to :appeal

  validates_presence_of :number, :registered_on

  after_create :register_appeal

  private
    def register_appeal
      self.appeal.to_register!
    end
end


# == Schema Information
#
# Table name: registrations
#
#  id            :integer         not null, primary key
#  registered_on :date
#  number        :string(255)
#  appeal_id     :integer
#  created_at    :datetime
#  updated_at    :datetime
#

