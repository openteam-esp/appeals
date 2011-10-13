# encoding: utf-8

require 'spec_helper'

describe Note do
  it "должен переводить обращение в состояние noted" do
    Fabricate(:note, :appeal => registered_appeal)
    registered_appeal.reload.should be_noted
  end
end
