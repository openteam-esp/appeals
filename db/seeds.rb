section = Section.find_or_create_by_title('Section #1')

%w[Topic1 Topic2 Topic3].each do |title|
  section.topics.find_or_create_by_title title
end
