# encoding: utf-8

require 'spec_helper'

describe Registration do
  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:registred_on) }

  it "должен переводить обращение в состояние зарегистрировано" do
    Registration.create! :number => "123", :registred_on => Date.today, :appeal => fresh_appeal
    fresh_appeal.reload.should be_registred
  end
end

