# encoding: utf-8

require 'spec_helper'

describe Appeal do
  it { should belong_to(:destroy_appeal_job) }
  it { should have_one(:address) }
  it { should have_one(:registration) }

  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:answer_kind) }

  it { Appeal.state_machines[:state].states.map(&:name).should == [:fresh, :closed, :registered] }
  it { Appeal.new(:state => 'fresh').state_events.should == [:register] }
  it { Fabricate(:reply, :appeal => registered_appeal); registered_appeal.state_events.should == [:close, :revert] }
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
    appeal.errors.keys.should == [:"address.region", :"address.township", :"address.district", :"address.postcode", :"address.street", :"address.house"]

    appeal.address_attributes = Fabricate.attributes_for(:address, :postcode => "")
    appeal.save
    appeal.errors.keys.should == [:"address.postcode"]
    appeal.should_not be_persisted

    appeal.address_attributes = Fabricate.attributes_for(:address)
    appeal.save
    appeal.errors.should be_empty
    appeal.should be_fresh
  end

  it "не должен валидировать адрес, если выбран ответ по email" do
    appeal = Appeal.new(Fabricate.attributes_for(:appeal, :answer_kind => 'email').merge(:address_attributes => {:region => "Томск"}))
    appeal.save
    appeal.errors.should be_empty
    appeal.should be_persisted
  end

  describe "закрытие обращения" do
    it "без ответа" do
      registered_appeal.close
      registered_appeal.should be_registered
    end

    it "c незаполенным ответом" do
      registered_appeal.create_reply!
      registered_appeal.reply.should be_persisted
      registered_appeal.close
      registered_appeal.reply.errors.keys.should == [:number, :replied_on, :replied_by, :text]
      registered_appeal.should be_registered
    end

    it "с заполненным ответом" do
      registered_appeal.create_reply Fabricate.attributes_for(:reply)
      registered_appeal.close
      registered_appeal.reply.errors.keys.should be_empty
      registered_appeal.should be_closed
    end
  end

  describe 'папки обращений' do
    it 'новые' do
      Appeal.folder(:fresh).where_values_hash.symbolize_keys.should == {:state => :fresh, :deleted_at => nil}
      Appeal.folder(:fresh).to_sql.should =~ /ORDER BY created_at/
    end

    it 'на рассмотрении' do
      Appeal.folder(:registered).where_values_hash.symbolize_keys.should == {:state => :registered, :deleted_at => nil}
      Appeal.folder(:registered).to_sql.should =~ /ORDER BY registrations.registered_on/
    end

    it "закрытые" do
      Appeal.folder(:closed).where_values_hash.symbolize_keys.should == {:state => :closed, :deleted_at => nil}
      Appeal.folder(:closed).to_sql.should =~ /ORDER BY replies.replied_on desc/
    end

    it "корзина" do
      Appeal.folder(:trash).to_sql.should =~ /deleted_at IS NOT NULL/
    end
  end

  describe 'переход в предыдущее состояние' do
    it 'registered -> fresh' do
      registered_appeal.revert

      registered_appeal.reload.should be_fresh
      registered_appeal.registration.should be_nil
    end

    it "closed -> registered" do
      closed_appeal.revert
      closed_appeal.reload.should be_registered
      closed_appeal.reply.should be_persisted
    end
  end

  describe "должно знать уровень важности для подсветки в виде" do
    it "для нового" do
      fresh_appeal.attention_level.should == "fresh_1_days"
    end

    it "для зарегистрированного" do
      create_registered_appeal(:registration => {:registered_on => 20.days.ago}).attention_level.should == "registered_21_days"
      registered_appeal.attention_level.should == "registered_1_days"
    end

    it "для закрытого" do
      closed_appeal.attention_level.should == "blank"
    end
  end

  describe 'корзина' do
    describe "удаление" do
      before do
        set_current_user
      end

      it { deleted_appeal.should be_persisted }
      it { deleted_appeal.should be_deleted }
      it { deleted_appeal.registration.should be_persisted }
      it { deleted_appeal.reply.should be_persisted }
      it { deleted_appeal.destroy_appeal_job.should be_persisted }

      it { deleted_appeal.destroy_without_trash.should_not be_persisted }
    end

    describe "восстановление" do
      it { restored_appeal.should be_persisted }
      it { restored_appeal.should_not be_deleted }
      it { restored_appeal.destroy_appeal_job.should_not be_persisted }
    end
  end

  describe "удаление минуя корзину" do
    let(:destroyed_appeal) { closed_appeal.destroy_without_trash }

    it { destroyed_appeal.should_not be_persisted }
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

