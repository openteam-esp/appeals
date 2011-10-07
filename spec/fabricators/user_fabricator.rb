# encoding: utf-8

require 'ryba'
require 'forgery'

Fabricator(:user) do
  name                  { Ryba::Name.full_name }
  email                 { Forgery(:internet).email_address }
  password              { Forgery(:basic).password }
  password_confirmation { |user| user.password }
end
