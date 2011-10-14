class UploadsController < AuthorizedApplicationController

  actions :create, :destroy

  belongs_to :reply, :optional => true

  respond_to :html

  def create
    create! { render :partial => "uploads/upload_form" and return }
  end

  def destroy
    destroy! {
      respond_with do |format|
        format.html do
          @reply = @upload.uploadable
          render :partial => "uploads/upload_form" and return
        end
      end
    }
  end
end
