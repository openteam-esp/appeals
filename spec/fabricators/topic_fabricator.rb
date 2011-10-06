require 'forgery'

Fabricator(:topic) do
  title { Forgery(:lorem_ipsum).words(2) }
end

