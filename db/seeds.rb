require 'ryba'

section = Section.find_or_create_by_title('Section #1')

%w[Topic1 Topic2 Topic3].each do |title|
  section.topics.find_or_create_by_title title
end

User.find_or_initialize_by_email('demo@demo.de').tap do | user |
  if user.new_record?
    user.update_attributes :password => '123123',
      :password_confirmation => '123123',
      :name => Ryba::Name.full_name
  end
end

