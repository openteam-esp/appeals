# encoding: utf-8

require 'spec_helper'

describe Appeal do
  it { Appeal.state_machines[:state].states.map(&:name).should == [:draft, :fresh, :registred, :replied] }
  it { Appeal.new.draft?.should be true }
  it { Appeal.new.state_events.should == [:dispatch] }
  it { Appeal.new(:state => 'fresh').state_events.should == [:register] }
  it { Appeal.new(:state => 'registred').state_events.should == [:reply, :revert] }
  it { Appeal.new(:state => 'replied').state_events.should == [:revert] }

  it { should have_one(:address) }
  it { should have_one(:registration) }

  describe "должен валидировать обращение в момент подачи" do
    before {
      @appeal = Appeal.new
      @appeal.save!
      @appeal.dispatch
    }
    it { @appeal.errors.keys.should include(:surname) }
    it { @appeal.errors.keys.should include(:name) }
    it { @appeal.errors.keys.should include(:text) }
    it { @appeal.errors.keys.should include(:topic) }
    it { @appeal.errors.keys.should include(:answer_kind) }

    it "должен требовать email если выбран ответ по email" do
      appeal = Fabricate(:appeal, :answer_kind => 'email', :email => '')
      appeal.dispatch
      appeal.errors.keys.should == [:email]
      appeal.update_attribute(:email, "demo@demo.de")
      appeal.dispatch
      appeal.errors.should be_empty
      appeal.should be_fresh
    end

    it "должен требовать адрес если выбран ответ по почте" do
      appeal = Fabricate(:appeal, :answer_kind => 'post')
      appeal.dispatch
      appeal.errors.keys.should == [:address]
      appeal.create_address(Fabricate.attributes_for(:address))
      appeal.dispatch
      appeal.errors.should be_empty
      appeal.should be_fresh
    end
  end

  describe "папки обращений" do
    it "новые" do
      Appeal.folder(:fresh).where_values_hash.symbolize_keys.should == {:state => :fresh}
      Appeal.folder(:fresh).to_sql.should =~ /ORDER BY created_at/
    end
  end

  require File.expand_path('spec/spec_helper')

  describe "переход в предыдущее состояние" do
    it "registred -> fresh" do
      registred_appeal.revert
      registred_appeal.should be_fresh
      registred_appeal.reload.registration.should be_nil
    end

  end
end

