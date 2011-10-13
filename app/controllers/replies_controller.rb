class RepliesController < AuthorizedApplicationController
  actions :create, :edit, :new, :update

  belongs_to :appeal, :singleton => true

  layout false

  def update
    update! { render @reply and return}
  end

  def create
    create! { render @reply and return}
  end
end
