class NotesController < AuthorizedApplicationController
  actions :create, :new

  belongs_to :appeal, :singleton => true

  layout false

  def create
    create! do |success, failure|
      success.html { render 'notes/note' }
      failure.html { render "appeals/show" }
    end
  end
end
