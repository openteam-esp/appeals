require 'forgery'
require 'ryba'

Fabricator(:appeal) do
  author      { Ryba::Name.full_name }
  phone       { Ryba::PhoneNumber.phone_number }
  email       { Forgery(:internet).email_address }
  text        { Forgery(:lorem_ipsum).words(5) }
  answer_kind 'email'
  topic!
  section!
end
