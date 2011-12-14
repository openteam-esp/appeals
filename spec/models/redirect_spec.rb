# encoding: utf-8

require 'spec_helper'

describe Redirect do
  it {should validate_presence_of(:recipient) }

  it "должен переводить обращение в состояние redirected" do
    Fabricate(:redirect, :appeal => registered_appeal)
    registered_appeal.reload.should be_redirected
  end
end
# == Schema Information
#
# Table name: redirects
#
#  id         :integer         not null, primary key
#  recipient  :string(255)
#  appeal_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

