class RegistrationsController < AuthorizedApplicationController
  actions :create, :new

  belongs_to :appeal, :singleton => true
end
