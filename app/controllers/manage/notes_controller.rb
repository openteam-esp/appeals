class Manage::NotesController < Manage::ApplicationController
  actions :create, :new

  belongs_to :appeal, :singleton => true

  layout 'system/appeal'

  def create
    create! do |success, failure|
      success.html { redirect_to manage_scoped_appeals_path(:folder => :registered) }
      failure.html { render "appeals/show" }
    end
  end
end
