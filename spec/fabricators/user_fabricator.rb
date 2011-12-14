# encoding: utf-8

require 'ryba'
require 'forgery'

Fabricator(:user) do
  uid       { sequence(:user_uid) }
  name      { Ryba::Name.full_name }
  email     { Forgery(:internet).email_address }
  sections  'section_one'
end
