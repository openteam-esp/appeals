require 'forgery'
require 'ryba'

Fabricator(:reply) do
  number      Appeal.new.send(:generate_code, 6, 3, '-')
  replied_on  { Date.today }
  text        { Forgery(:lorem_ipsum).words(10) }
  public      false
  replied_by  { Ryba::Name.full_name }
end
