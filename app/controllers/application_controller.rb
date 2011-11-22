class ApplicationController < ActionController::Base

  protect_from_forgery

  layout :resolve_layout

  helper_method :uploads

  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Allow-Headers'] = '*'
  end

  protected

    def resolve_layout
      if devise_controller?
        "login"
      else
        "application"
      end
    end

    def uploads
      session[:upload_ids] ||= []
      uploads = Upload.find_all_by_id(session[:upload_ids])
      session[:upload_ids] = uploads.map(&:id)
      uploads
    end
end
