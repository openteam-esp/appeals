# encoding: utf-8

require 'spec_helper'

describe Appeal do
  it { should have_one(:address) }
  it { should have_one(:registration) }

  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:answer_kind) }

  it { Appeal.state_machines[:state].states.map(&:name).should == [:fresh, :registred, :replied] }

  it { Appeal.new(:state => 'fresh').state_events.should == [:register] }
  it { Appeal.new(:state => 'registred').state_events.should == [:reply, :revert] }
  it { Appeal.new(:state => 'replied').state_events.should == [:revert] }

  describe "при создании обращения" do
    it { Fabricate(:appeal).should be_fresh }

    it "должен генерироваться уникальный код" do
      appeal = Fabricate(:appeal)
      appeal.code.should =~ /\d{3}-\d{3}-\d{3}-\d{3}/
    end
  end

  it "должен требовать email если выбран ответ по email" do
    appeal = Fabricate.build(:appeal, :answer_kind => 'email', :email => '')
    appeal.save

    appeal.errors.keys.should == [:email]

    appeal.email = "demo@demo.de"
    appeal.save

    appeal.errors.should be_empty
    appeal.should be_fresh
  end

  it "должен требовать адрес если выбран ответ по почте" do
    appeal = Fabricate.build(:appeal, :answer_kind => 'post')
    appeal.save

    appeal.errors.keys.should == [:address]

    appeal.address_attributes = Fabricate.attributes_for(:address)
    appeal.save

    appeal.errors.should be_empty
    appeal.should be_fresh
  end

  describe "папки обращений" do
    it "новые" do
      Appeal.folder(:fresh).where_values_hash.symbolize_keys.should == {:state => :fresh}
      Appeal.folder(:fresh).to_sql.should =~ /ORDER BY created_at/
    end
  end

  describe "переход в предыдущее состояние" do
    it "registred -> fresh" do
      registred_appeal.revert

      registred_appeal.reload.should be_fresh
      registred_appeal.registration.should be_nil
    end
  end

end

