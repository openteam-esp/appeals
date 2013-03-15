# encoding: utf-8
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


require 'spec_helper'

describe Note do
  it "должен переводить обращение в состояние noted" do
    Fabricate(:note, :appeal => registered_appeal)
    registered_appeal.reload.should be_noted
  end
end
