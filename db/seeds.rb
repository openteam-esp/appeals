# encoding: utf-8

require 'fabrication'
require 'forgery'
require 'ryba'

@section = Section.find_or_create_by_title_and_slug(:title => 'Section #1', :slug => 'section_one')

@topic1 = @section.topics.find_or_create_by_title "Конституционный строй"
@topic2 = @section.topics.find_or_create_by_title "Основы государственного управления"

@section.topics.find_or_create_by_title "Гражданское право"
@section.topics.find_or_create_by_title "Семья"
@section.topics.find_or_create_by_title "Жилище"
@section.topics.find_or_create_by_title "Труд и занятость населения"
@section.topics.find_or_create_by_title "Социальное обеспечение и социальное страхование"
@section.topics.find_or_create_by_title "Финансы"
@section.topics.find_or_create_by_title "Хозяйственная деятельность"
@section.topics.find_or_create_by_title "Внешнеэкономическая деятельность. Таможенное дело"
@section.topics.find_or_create_by_title "Природные ресурсы и охрана окружающей природной среды"
@section.topics.find_or_create_by_title "Информация и информатизация"
@section.topics.find_or_create_by_title "Образование. Наука. Культура"
@section.topics.find_or_create_by_title "Здравоохранение. Физическая культура и спорт. Туризм"
@section.topics.find_or_create_by_title "Оборона"
@section.topics.find_or_create_by_title "Безопасность и охрана правопорядка"
@section.topics.find_or_create_by_title "Уголовное право. Исполнение наказаний"
@section.topics.find_or_create_by_title "Правосудие"
@section.topics.find_or_create_by_title "Прокуратура. Органы юстиции. Адвокатура. Нотариат"
@section.topics.find_or_create_by_title "Международные отношения. Международное право"
@section.topics.find_or_create_by_title "Индивидуальные правовые акты по кадровым вопросам, вопросам награждения, помилования, гражданства, присвоение почетных и иных званий."

User.find_or_initialize_by_uid('1').tap do | user |
  user.email = 'demo@demo.de'
  user.name = Ryba::Name.full_name
  user.sections = 'section_one'
  user.save!
end

def create_appeal
  options = rand(4) > 1 ? {:answer_kind => 'email', :topic => @topic1} : {:section => @section, :topic => @topic2, :answer_kind => 'post', :email => rand(2) > 1 ? nil : Forgery(:internet).email_address }
  options.merge!(:text => Forgery(:lorem_ipsum).words(rand(100)))

  Fabricate.build(:appeal, options).tap do |appeal|
    appeal.address_attributes = Fabricate.attributes_for(:address) if appeal.answer_kind_post?
    appeal.save!
  end
end

def rand_days_ago(days)
  rand(days*24*60).minutes.ago
end

def create_registered_appeal
  appeal = create_appeal
  appeal.create_registration(:number => appeal.send(:generate_code, 4, 2, '/'), :registered_on => rand_days_ago(30))
  appeal.reload
end

def create_noted_appeal
  create_registered_appeal.create_note
end

def create_redirected_appeal
  create_registered_appeal.create_redirect(:recipient => Ryba::Name.full_name)
end

def create_reviewing_appeal
  appeal = create_registered_appeal
  appeal.create_review(:recipient => Ryba::Name.full_name)
  appeal.reload
end

Appeal.destroy_all

10.times do
  create_appeal
end

20.times do
  create_registered_appeal
  create_noted_appeal
  create_redirected_appeal
  create_reviewing_appeal
end

10.times do
  appeal = create_reviewing_appeal
  appeal.reply.update_attributes Fabricate.attributes_for(:reply).merge(:replied_on => rand_days_ago(60))
  appeal.to_close!
end

Appeal.record_timestamps = false

Appeal.folder(:fresh).each do |a|
  a.update_attribute :created_at, rand_days_ago(4)
end
