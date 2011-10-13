# encoding: utf-8

require 'spec_helper'

describe Redirect do
  it {should validate_presence_of(:recipient) }

  it "должен переводить обращение в состояние redirected" do
    Fabricate(:redirect, :appeal => registered_appeal)
    registered_appeal.reload.should be_redirected
  end
end
