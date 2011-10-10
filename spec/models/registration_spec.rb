# encoding: utf-8

require 'spec_helper'

describe Registration do
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:registred_on) }

  it "должен переводить обращение в состояние зарегистрировано" do
    Fabricate(:registration, :appeal => fresh_appeal)
    fresh_appeal.reload.should be_registred
  end
end


# == Schema Information
#
# Table name: registrations
#
#  id           :integer         not null, primary key
#  registred_on :date
#  number       :string(255)
#  directed_to  :string(255)
#  appeal_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#

