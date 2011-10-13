class Public::UploadsController < ApplicationController

  respond_to :html

  def create
    session[:upload_ids] ||= []
    session[:upload_ids] << Upload.create!(params[:upload]).id
    render :partial => "public/uploads/upload_form"
  end

  def destroy
    session[:upload_ids] ||= []
    session[:upload_ids] << Upload.destroy(params[:id]).id
    respond_with do |format|
      format.html do
        render :partial => "public/uploads/upload_form"
      end
    end
  end

end
