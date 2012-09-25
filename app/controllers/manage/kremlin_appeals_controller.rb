class Manage::KremlinAppealsController < Manage::AppealsController
  actions :create, :new, :destroy

  defaults :resource_class => KremlinAppeal, :instance_name => 'appeal'

  def create
    create! do |success, falilure|
      success.html { redirect_to manage_appeal_path(resource) }
    end
  end
end
