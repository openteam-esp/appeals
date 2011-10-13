class Public::UploadsController < ApplicationController

  def create
    session[:upload_ids] ||= []
    session[:upload_ids] << Upload.create!(params[:upload]).id
    render :partial => "public/uploads/upload_form"
  end

end
