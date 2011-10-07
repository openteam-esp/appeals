Fabricator(:registration) do
  registred_on { Date.today }
  number '13'
  directed_to 'Ivanov'
end
