class Public::UploadsController < ApplicationController

  def create
    session[:upload_ids] ||= []
    session[:upload_ids] << Upload.create!.id
    @uploads = Upload.find(session[:upload_ids])
    render @uploads
  end

end
