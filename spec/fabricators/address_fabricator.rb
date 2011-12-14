require 'forgery'
require 'ryba'

Fabricator(:address) do
  postcode  { Ryba::Address.index }
  district  { Ryba::Address.city }
  region    { |address| Ryba::Data::RegionByCities[address.district.gsub(' ', '_')].first  }
  township  { |address| Ryba.pick(Ryba::Data::CitiesByRegion[address.region].compact).gsub('_', ' ') }
  street    { Forgery(:address).street_name }
  house     { Forgery(:address).street_number }
end
