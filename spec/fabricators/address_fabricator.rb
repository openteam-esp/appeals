require 'forgery'
require 'ryba'

Fabricator(:address) do
  postcode  { Ryba::Address.index }
  district  { Ryba::Address.city }
  region    { |address| Ryba::Data::RegionByCities[address.district].clone.first }
  township  { |address| Ryba.pick(Ryba::Data::CitiesByRegion[address.region]) || address.region }
  street    { Forgery(:address).street_name }
  house     { Forgery(:address).street_number }
end
