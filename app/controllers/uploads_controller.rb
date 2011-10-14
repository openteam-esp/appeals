class UploadsController < AuthorizedApplicationController

  actions :create, :destroy

  belongs_to :reply, :optional => true

  def create
    create! { render :partial => "uploads/upload_form" and return }
  end

  def destroy
    destroy! { render :partial => "uploads/upload_form" and return }
  end
end
