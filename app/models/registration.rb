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
#  id           :integer         not null, primary key
#  appeal_id    :integer
#  registred_on :date
#  number       :string(255)
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

