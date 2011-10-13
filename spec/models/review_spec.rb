# encoding: utf-8

require 'spec_helper'

describe Review do
  it "должен переводить обращение в состояние reviewing" do
    Fabricate(:review, :appeal => registered_appeal)
    registered_appeal.reload.should be_reviewing
  end
end

