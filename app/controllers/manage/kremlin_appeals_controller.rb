class Manage::KremlinAppealsController < Manage::ApplicationController
  layout 'system/kremlin'

  def create
    create! do |success, falilure|
      success.html { redirect_to manage_appeal_path(resource) }
    end
  end

end
