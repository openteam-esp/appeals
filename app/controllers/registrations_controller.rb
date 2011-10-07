class RegistrationsController < AuthorizedApplicationController
  actions :create, :edit, :new, :update

  belongs_to :appeal, :singleton => true
end
