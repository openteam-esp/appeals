# encoding: utf-8

require 'spec_helper'

describe Review do
  it {should validate_presence_of(:recipient) }

  it "должен переводить обращение в состояние reviewing" do
    Fabricate(:review, :appeal => registered_appeal)
    registered_appeal.reload.should be_reviewing
  end
end

# == Schema Information
#
# Table name: reviews
#
#  id         :integer         not null, primary key
#  recipient  :string(255)
#  appeal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

