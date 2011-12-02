class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :resolve_layout

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
end
