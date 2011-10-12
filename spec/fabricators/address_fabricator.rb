require 'forgery'
require 'ryba'

Fabricator(:address) do
  region   { Forgery(:address).state }
  district { Forgery(:address).province }
  township { Forgery(:address).city }
  postcode { Forgery(:address).zip }
  street   { Forgery(:address).street_name }
  house    { Forgery(:address).street_number }
end
