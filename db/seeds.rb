# encoding: utf-8

User.find_or_initialize_by_uid('1').tap do | user |
  user.save(:validate => false)
  user.permissions.create! :context => Context.first, :role => :manager if user.permissions.empty?
end

Section.find_or_initialize_by_context_id(48).tap do | s |
  s.update_attributes(:title => 'Section #1')
  s.topics.find_or_create_by_title "Конституционный строй"
  s.topics.find_or_create_by_title "Основы государственного управления"
  s.topics.find_or_create_by_title "Гражданское право"
  s.topics.find_or_create_by_title "Семья"
  s.topics.find_or_create_by_title "Жилище"
  s.topics.find_or_create_by_title "Труд и занятость населения"
  s.topics.find_or_create_by_title "Социальное обеспечение и социальное страхование"
  s.topics.find_or_create_by_title "Финансы"
  s.topics.find_or_create_by_title "Хозяйственная деятельность"
  s.topics.find_or_create_by_title "Внешнеэкономическая деятельность. Таможенное дело"
  s.topics.find_or_create_by_title "Природные ресурсы и охрана окружающей природной среды"
  s.topics.find_or_create_by_title "Информация и информатизация"
  s.topics.find_or_create_by_title "Образование. Наука. Культура"
  s.topics.find_or_create_by_title "Здравоохранение. Физическая культура и спорт. Туризм"
  s.topics.find_or_create_by_title "Оборона"
  s.topics.find_or_create_by_title "Безопасность и охрана правопорядка"
  s.topics.find_or_create_by_title "Уголовное право. Исполнение наказаний"
  s.topics.find_or_create_by_title "Правосудие"
  s.topics.find_or_create_by_title "Прокуратура. Органы юстиции. Адвокатура. Нотариат"
  s.topics.find_or_create_by_title "Международные отношения. Международное право"
  s.topics.find_or_create_by_title "Индивидуальные правовые акты по кадровым вопросам, вопросам награждения, помилования, гражданства, присвоение почетных и иных званий."
end

if family_department_context = Context.find_by_title('Департамент по вопросам семьи и детей Томской области')
  Section.find_or_initialize_by_context_id(family_department_context.id).tap do |section|
    section.update_attributes :title => 'Департамент по вопросам семьи и детей Томской области'

    section.topics.find_or_create_by_title 'Отдых, оздоровление и занятость детей'
    section.topics.find_or_create_by_title 'Опека и попечительство'
    section.topics.find_or_create_by_title 'Помощь детям-сиротам'
  end
end

