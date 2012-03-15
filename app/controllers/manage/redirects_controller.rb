class Manage::RedirectsController < Manage::ApplicationController
  actions :create, :new

  belongs_to :appeal, :singleton => true

  layout false

  protected

    def smart_resource_url
      manage_scoped_appeals_path(:folder => :registered)
    end
end
