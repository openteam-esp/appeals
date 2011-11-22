require 'forgery'
require 'ryba'

Fabricator(:appeal) do
  surname     { Ryba::Name.family_name }
  name        { Ryba::Name.first_name }
  phone       { Ryba::PhoneNumber.phone_number }
  email       { Forgery(:internet).email_address }
  text        { Forgery(:lorem_ipsum).words(5) }
  answer_kind 'email'
  topic!
  section_id Section.find_or_create_by_slug(:slug => 'JOPA', :title => 'jopa')
end
