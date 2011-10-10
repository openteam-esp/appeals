class ApplicationController < ActionController::Base

  protect_from_forgery

  layout :resolve_layout

  protected
  def resolve_layout
    if devise_controller?
      "login"
    else
      "application"
    end
  end

end
