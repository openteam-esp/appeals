# encoding: utf-8

require 'fabrication'
require 'forgery'
require 'ryba'

section = Section.find_or_create_by_title('Section #1')

@topic1 = section.topics.find_or_create_by_title "Конституционный строй"
@topic2 = section.topics.find_or_create_by_title "Основы государственного управления"

section.topics.find_or_create_by_title "Гражданское право"
section.topics.find_or_create_by_title "Семья"
section.topics.find_or_create_by_title "Жилище"
section.topics.find_or_create_by_title "Труд и занятость населения"
section.topics.find_or_create_by_title "Социальное обеспечение и социальное страхование"
section.topics.find_or_create_by_title "Финансы"
section.topics.find_or_create_by_title "Хозяйственная деятельность"
section.topics.find_or_create_by_title "Внешнеэкономическая деятельность. Таможенное дело"
section.topics.find_or_create_by_title "Природные ресурсы и охрана окружающей природной среды"
section.topics.find_or_create_by_title "Информация и информатизация"
section.topics.find_or_create_by_title "Образование. Наука. Культура"
section.topics.find_or_create_by_title "Здравоохранение. Физическая культура и спорт. Туризм"
section.topics.find_or_create_by_title "Оборона"
section.topics.find_or_create_by_title "Безопасность и охрана правопорядка"
section.topics.find_or_create_by_title "Уголовное право. Исполнение наказаний"
section.topics.find_or_create_by_title "Правосудие"
section.topics.find_or_create_by_title "Прокуратура. Органы юстиции. Адвокатура. Нотариат"
section.topics.find_or_create_by_title "Международные отношения. Международное право"
section.topics.find_or_create_by_title "Индивидуальные правовые акты по кадровым вопросам, вопросам награждения, помилования, гражданства, присвоение почетных и иных званий."

User.find_or_initialize_by_email('demo@demo.de').tap do | user |
  if user.new_record?
    user.update_attributes :password => '123123',
      :password_confirmation => '123123',
      :name => Ryba::Name.full_name
  end
end

def create_appeal
  options = rand(4) > 1 ? {:answer_kind => 'email', :topic => @topic1} : {:topic => @topic2, :answer_kind => 'post', :email => rand(2) > 1 ? nil : Forgery(:internet).email_address }

  Fabricate.build(:appeal, options).tap do |appeal|
    appeal.address_attributes = Fabricate.attributes_for(:address) if appeal.answer_kind_post?
    appeal.save!
  end
end

Appeal.destroy_all
10.times do
  create_appeal
end

20.times do
 appeal = create_appeal
 appeal.create_registration(:number => appeal.send(:generate_code, 4, 2, '/'), :registred_on => Date.today - rand(30).days, :directed_to => Ryba::Name.full_name)
end
