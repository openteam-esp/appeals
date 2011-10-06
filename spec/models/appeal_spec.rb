# encoding: utf-8

require 'spec_helper'

describe Appeal do
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:answer_kind) }

  it "должен требовать email если выбран ответ по email" do
    appeal = Fabricate.build(:appeal, :answer_kind => 'email', :email => '')
    appeal.save
    appeal.errors.keys.should == [:email]
  end

  it "должен требовать адрес если выбран ответ по почте" do
    appeal = Fabricate.build(:appeal, :answer_kind => 'post')
    appeal.save
    appeal.errors.keys.should == [:address]
  end
end

