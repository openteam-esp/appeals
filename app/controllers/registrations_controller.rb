class RegistrationsController < AuthorizedApplicationController
  actions :create, :new

  belongs_to :appeal

  def create
    create! { scoped_appeals_path(:folder => :fresh) }
  end

  protected
    def build_resource
      @registration = parent.build_registration(params[:registration])
    end
end
