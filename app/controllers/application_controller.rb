class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :resolve_layout

  after_filter :set_access_control_headers

  protected
    def set_access_control_headers
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Allow-Headers'] = '*'
    end

    def resolve_layout
      devise_controller? ? 'login' : 'application'
    end
end
