# encoding: utf-8
# == Schema Information
#
# Table name: reviews
#
#  id         :integer          not null, primary key
#  appeal_id  :integer
#  recipient  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require 'spec_helper'

describe Review do
  it {should validate_presence_of(:recipient) }

  it "должен переводить обращение в состояние reviewing" do
    Fabricate(:review, :appeal => registered_appeal)
    registered_appeal.reload.should be_reviewing
  end
end
