require 'forgery'

Fabricator(:section) do
  title { Forgery(:lorem_ipsum).words(2) }
  slug { Forgery(:basic).encrypt }
end

