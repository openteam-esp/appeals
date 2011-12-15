# encoding: utf-8
require 'forgery'
require 'ryba'

BuildingFormats = [
  [ 'д. #', 90 ],
  [ 'д.#', 80 ],
  [ 'д. #/?', 15 ],
  [ 'д. #к?', 10 ],
  [ 'стр. #', 10 ],
  [ 'д.#/?', 5 ],
  [ 'д.#к?', 5 ],
  [ 'стр.#', 5 ],
]

Fabricator(:address) do
  postcode  { Ryba::Address.index }
  district  { Ryba::Address.city }
  region    { |address| Ryba::Data::RegionByCities[address.district.gsub(' ', '_')].first  }
  township  { |address| Ryba.pick(Ryba::Data::CitiesByRegion[address.region].compact).gsub('_', ' ') }
  street    { Ryba::Address.street }
  house     {
    building = Ryba.pick(1..200)

    if rand(10) < 2
      "#{building}"
    else
      formatter = lambda do |fmts, num|
        Ryba.weighted_pick(fmts).gsub('#', num.to_s).gsub('?', Ryba.pick(1..9).to_s)
      end
      formatter.call(BuildingFormats, building)
    end
  }
end
