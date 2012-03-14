# encoding: utf-8

require 'spec_helper'

describe Registration do
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:registered_on) }

  it "должен переводить обращение в состояние зарегистрировано" do
    Fabricate(:registration, :appeal => fresh_appeal)
    fresh_appeal.reload.should be_registered
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

