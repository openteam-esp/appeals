class AppealsController < AuthorizedApplicationController
  actions :index, :show

  has_scope :folder
end
