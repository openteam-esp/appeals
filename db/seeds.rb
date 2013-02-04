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

    section.topics.find_or_create_by_title 'Обеспечение жильем детей-сирот, детей, оставшихся без попечения родителей, а также лиц из их числа.'
    section.topics.find_or_create_by_title 'Обеспечение жильем многодетных семей.'
    section.topics.find_or_create_by_title 'Улучшение жилищных условий детей-сирот, детей, оставшихся без попечения родителей, а также лиц из их числа.'
    section.topics.find_or_create_by_title 'Улучшение жилищных условий многодетных семей.'
    section.topics.find_or_create_by_title 'Улучшение жилищных условий семей, имеющих детей-инвалидов.'
    section.topics.find_or_create_by_title 'Ремонт жилого помещения, принадлежащего на праве собственности детям-сиротам, детям, оставшихся без попечения родителей, а также лицам из их числа.'
    section.topics.find_or_create_by_title 'Обеспечение земельным участком многодетных семей.'
    section.topics.find_or_create_by_title 'Предоставление льгот детям-сиротам, детям, оставшимся без попечения родителей, а также лицам из их числа.'
    section.topics.find_or_create_by_title 'Предоставление льгот многодетным семьям.'
    section.topics.find_or_create_by_title 'Предоставление льгот семьям, имеющим детей инвалидов.'
    section.topics.find_or_create_by_title 'Оказание материальной помощи, предоставление материальных ценностей.'
    section.topics.find_or_create_by_title 'Выплата денежных средств многодетным семьям на содержание ребенка (детей).'
    section.topics.find_or_create_by_title 'Выплата вознаграждения приемным родителям.'
    section.topics.find_or_create_by_title 'Обеспечение новогодними подарками детей.'
    section.topics.find_or_create_by_title 'Участие в новогодней делегации на Кремлевскую елку.'
    section.topics.find_or_create_by_title 'Установление (прекращение) опеки (попечительства).'
    section.topics.find_or_create_by_title 'Усыновление (удочерение). Отказ от усыновления (удочерения).'
    section.topics.find_or_create_by_title 'Лишение (восстановление) родительских прав.'
    section.topics.find_or_create_by_title 'Перевод детей в учреждение, подведомственное Департаменту по вопросам семьи и детей Томской области.'
    section.topics.find_or_create_by_title 'Организация и обеспечение отдыха. Возмещение затрат на отдых и оздоровление детей.'
    section.topics.find_or_create_by_title 'Обеспечение занятости детей.'
    section.topics.find_or_create_by_title 'Предоставление материнского капитала (федерального, регионального).'
    section.topics.find_or_create_by_title 'Получение образования детьми-сиротами и детьми, оставшимися без попечения родителями, а также лицами из их числа.'
    section.topics.find_or_create_by_title 'Трудовые споры, кадровые вопросы.'
    section.topics.find_or_create_by_title 'Организация деятельности учреждений, подведомственных Департаменту по вопросу семьи и детей Томской области.'
    section.topics.find_or_create_by_title 'Награждение Почетными грамотами, Благодарностями, Благодарственными письмами.'
    section.topics.find_or_create_by_title 'Награждение знаком отличия «Родительская доблесть».'
    section.topics.find_or_create_by_title 'Награждение знаком отличия «За любовь и верность».'
    section.topics.find_or_create_by_title 'Запрос о предоставлении информации (консультации).'
    section.topics.find_or_create_by_title 'Иной вопрос, отсутствующий в перечне тематического классификатора обращений граждан в Департамент по вопросам семьи и детей Томской области.'
  end
end

