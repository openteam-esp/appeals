# encoding: utf-8

require 'spec_helper'

describe Appeal do
  it { should belong_to(:topic) }
  it { should belong_to(:section) }

  it { should have_one(:address).dependent(:destroy) }
  it { should have_one(:note).dependent(:destroy) }
  it { should have_one(:redirect).dependent(:destroy) }
  it { should have_one(:registration).dependent(:destroy) }
  it { should have_one(:review).dependent(:destroy) }

  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:text) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:section) }
  it { should validate_presence_of(:answer_kind) }

  it { Appeal.state_machines[:state].states.map(&:name).should == [:fresh, :closed, :noted, :redirected, :registered, :reviewing] }

  it { fresh_appeal.state_events.should == [:to_register] }
  it { registered_appeal.state_events.should == [:to_note, :to_redirect, :to_review, :to_revert] }
  it { noted_appeal.state_events.should == [:to_revert] }
  it { redirected_appeal.state_events.should == [:to_revert] }

  it "reviewing_appeal events" do
    reviewing_appeal.stub!(:reply_valid?).and_return(true)
    reviewing_appeal.state_events.should == [:to_close, :to_revert]
  end

  it { closed_appeal.state_events.should == [:to_revert] }

  describe 'валидация email' do
    it 'должна пропускать ololo@ololo.com' do
      appeal = Fabricate.build(:appeal, :email => 'ololo@ololo.com', :section => section(root))
      appeal.save
      appeal.errors.keys.should be_empty
    end

    it 'не должна пропускать blah' do
      appeal = Fabricate.build(:appeal, :email => 'blah', :section => section(root))
      appeal.save
      appeal.errors.keys.should == [:email]
    end
  end

  describe 'при создании обращения' do
    it { Fabricate(:appeal, :section => section(root)).should be_fresh }

    it 'должен генерироваться уникальный код' do
      appeal = Fabricate(:appeal, :section => section(root))
      appeal.code.should =~ /\d{3}-\d{3}-\d{3}-\d{3}/
    end
  end

  it 'должен требовать email если выбран ответ по email' do
    appeal = Fabricate.build(:appeal, :answer_kind => 'email', :email => '', :section => section(root))
    appeal.save

    appeal.errors.keys.should == [:email]

    appeal.email = 'demo@demo.de'
    appeal.save

    appeal.errors.should be_empty
    appeal.should be_fresh
  end

  it 'должен требовать адрес если выбран ответ по почте' do
    appeal = Fabricate.build(:appeal, :answer_kind => 'post', :section => section(root))
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
    appeal = Appeal.new(Fabricate.attributes_for(:appeal, :answer_kind => 'email', :section => section(root)).merge(:address_attributes => {:region => "Томск"}))
    appeal.save
    appeal.errors.should be_empty
    appeal.should be_persisted
  end

  describe 'при переводе обращения на рассмотрение должен создаваться ответ' do
    it { reviewing_appeal.reply.should be_persisted }
  end

  describe "закрытие обращения" do
    it "без ответа" do
      reviewing_appeal.to_close
      reviewing_appeal.should be_reviewing
    end

    it "c незаполенным ответом" do
      reviewing_appeal.create_reply!
      reviewing_appeal.reply.should be_persisted
      reviewing_appeal.to_close
      reviewing_appeal.reply.errors.keys.should == [:number, :replied_on, :replied_by, :text]
      reviewing_appeal.should be_reviewing
    end

    it "с заполненным ответом" do
      reviewing_appeal.create_reply Fabricate.attributes_for(:reply)
      reviewing_appeal.to_close
      reviewing_appeal.reply.errors.keys.should be_empty
      reviewing_appeal.should be_closed
    end
  end

  describe 'папки обращений' do
    it 'новые' do
      Appeal.folder(:fresh).where_values_hash.symbolize_keys.should == {:state => :fresh, :deleted_at => nil}
      Appeal.folder(:fresh).to_sql.should =~ /ORDER BY appeals.created_at/
    end

    it "зарегистрированные" do
      Appeal.folder(:registered).where_values_hash.symbolize_keys.should == {:state => :registered, :deleted_at => nil}
      Appeal.folder(:registered).to_sql.should =~ /ORDER BY registrations.registered_on/
    end

    it 'на рассмотрении' do
      Appeal.folder(:reviewing).where_values_hash.symbolize_keys.should == {:state => :reviewing, :deleted_at => nil}
      Appeal.folder(:reviewing).to_sql.should =~ /ORDER BY reviews.created_at/
    end

    it "закрытые" do
      Appeal.folder(:closed).where_values_hash.symbolize_keys.should == {:state => :closed, :deleted_at => nil}
      Appeal.folder(:closed).to_sql.should =~ /ORDER BY replies.replied_on desc/
    end

    it "принятые к сведению" do
      Appeal.folder(:noted).where_values_hash.symbolize_keys.should == {:state => :noted, :deleted_at => nil}
      Appeal.folder(:noted).to_sql.should =~ /ORDER BY notes.created_at/
    end

    it "переадресованные" do
      Appeal.folder(:redirected).where_values_hash.symbolize_keys.should == {:state => :redirected, :deleted_at => nil}
      Appeal.folder(:redirected).to_sql.should =~ /ORDER BY redirects.created_at/
    end

    it "корзина" do
      Appeal.folder(:trash).to_sql.should =~ /deleted_at IS NOT NULL/
    end
  end

  describe 'переход в предыдущее состояние' do
    it 'registered -> fresh' do
      registered_appeal.to_revert

      registered_appeal.reload.should be_fresh
      registered_appeal.registration.should be_nil
    end

    it "noted -> registered" do
      noted_appeal.to_revert

      noted_appeal.reload.should be_registered
      noted_appeal.reload.note.should be_nil
    end

    it "redirected -> registered" do
      redirected_appeal.to_revert

      redirected_appeal.reload.should be_registered
      redirected_appeal.reload.redirect.should be_nil
    end

    it "reviewing -> registered" do
      reviewing_appeal.to_revert

      reviewing_appeal.reload.should be_registered
      reviewing_appeal.reload.review.should be_nil
    end

    it "closed -> reviewing" do
      closed_appeal.to_revert

      closed_appeal.reload.should be_reviewing
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

    it { reviewing_appeal.attention_level.should_not == "blank" }

    it { closed_appeal.attention_level.should == "blank" }
    it { redirected_appeal.attention_level.should == "blank" }
    it { noted_appeal.attention_level.should == "blank" }
  end

  describe 'корзина' do
    describe "удаление" do
      it { deleted_appeal.should be_persisted }
      it { deleted_appeal.should be_deleted }
      it { deleted_appeal.registration.should be_persisted }
      it { deleted_appeal.review.should be_persisted }
      it { deleted_appeal.reply.should be_persisted }
    end

    describe "восстановление" do
      it { restored_appeal.should be_persisted }
      it { restored_appeal.should_not be_deleted }
    end
  end

  describe "удаление минуя корзину" do
    let(:destroyed_appeal) { closed_appeal.destroy }

    it { destroyed_appeal.should_not be_persisted }
  end

  context 'созданное обращение' do
    describe 'после сохранения' do
      let(:appeal) { Fabricate :appeal, :root_path => nil, :section => section(root) }

      it { appeal.root_path.should_not be_blank }
    end
  end
end



# == Schema Information
#
# Table name: appeals
#
#  id            :integer         not null, primary key
#  deleted_by_id :integer
#  section_id    :integer
#  topic_id      :integer
#  public        :boolean
#  deleted_at    :datetime
#  answer_kind   :string(255)
#  code          :string(255)
#  email         :string(255)
#  name          :string(255)
#  surname       :string(255)
#  patronymic    :string(255)
#  phone         :string(255)
#  root_path     :string(255)
#  social_status :string(255)
#  state         :string(255)
#  user_agent    :text
#  user_ip       :string(255)
#  user_proxy_ip :string(255)
#  user_referrer :text
#  text          :text
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#

