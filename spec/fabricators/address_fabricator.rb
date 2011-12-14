require 'forgery'
require 'ryba'

Fabricator(:address) do
  postcode  { Ryba::Address.index }
  district  { Ryba::Address.city }
  region    { |address| Ryba::Data::RegionByCities.dup[address.district].first  }
  township  { |address| Ryba.pick(Ryba::Data::CitiesByRegion.dup[address.region]) || address.region }
  street    { Forgery(:address).street_name }
  house     { Forgery(:address).street_number }
end
