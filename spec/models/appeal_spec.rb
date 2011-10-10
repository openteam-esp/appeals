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

  it { Appeal.state_machines[:state].states.map(&:name).should == [:fresh, :registred, :closed] }

  it { Appeal.new(:state => 'fresh').state_events.should == [:register] }
  it { Fabricate(:reply, :appeal => registred_appeal); registred_appeal.state_events.should == [:close, :revert] }
  it { Appeal.new(:state => 'closed').state_events.should == [:revert] }

  describe 'при создании обращения' do
    it { Fabricate(:appeal).should be_fresh }

    it 'должен генерироваться уникальный код' do
      appeal = Fabricate(:appeal)
      appeal.code.should =~ /\d{3}-\d{3}-\d{3}-\d{3}/
    end
  end

  it 'должен требовать email если выбран ответ по email' do
    appeal = Fabricate.build(:appeal, :answer_kind => 'email', :email => '')
    appeal.save

    appeal.errors.keys.should == [:email]

    appeal.email = 'demo@demo.de'
    appeal.save

    appeal.errors.should be_empty
    appeal.should be_fresh
  end

  it 'должен требовать адрес если выбран ответ по почте' do
    appeal = Fabricate.build(:appeal, :answer_kind => 'post')
    appeal.save

    appeal.errors.keys.should == [:address]

    appeal.address_attributes = Fabricate.attributes_for(:address)
    appeal.save

    appeal.errors.should be_empty
    appeal.should be_fresh
  end

  describe "закрытие обращения" do
    it "без ответа" do
      registred_appeal.close
      registred_appeal.should be_registred
    end

    it "c незаполенным ответом" do
      registred_appeal.create_reply!
      registred_appeal.reply.should be_persisted
      registred_appeal.close
      registred_appeal.reply.errors.keys.should == [:number, :replied_on, :replied_by, :text]
      registred_appeal.should be_registred
    end

    it "с заполненным ответом" do
      registred_appeal.create_reply Fabricate.attributes_for(:reply)
      registred_appeal.close
      registred_appeal.reply.errors.keys.should be_empty
      registred_appeal.should be_closed
    end
  end

  describe 'папки обращений' do
    it 'новые' do
      Appeal.folder(:fresh).where_values_hash.symbolize_keys.should == {:state => :fresh}
      Appeal.folder(:fresh).to_sql.should =~ /ORDER BY created_at/
    end
    it 'на рассмотрении' do
      Appeal.folder(:registred).where_values_hash.symbolize_keys.should == {:state => :registred}
      Appeal.folder(:registred).to_sql.should =~ /ORDER BY created_at/
    end
  end

  describe 'переход в предыдущее состояние' do
    it 'registred -> fresh' do
      registred_appeal.revert

      registred_appeal.reload.should be_fresh
      registred_appeal.registration.should be_nil
    end
  end
end


# == Schema Information
#
# Table name: appeals
#
#  id          :integer         not null, primary key
#  surname     :string(255)
#  name        :string(255)
#  patronymic  :string(255)
#  topic_id    :integer
#  email       :string(255)
#  phone       :string(255)
#  text        :text
#  public      :boolean
#  answer_kind :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  state       :string(255)
#  code        :string(255)
#  user_ip     :string(255)
#  proxy_ip    :string(255)
#  user_agent  :string(255)
#  referrer    :string(255)
#

