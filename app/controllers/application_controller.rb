class ApplicationController < ActionController::Base

  protect_from_forgery

  layout :resolve_layout

  helper_method :uploads

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
    end
end
