class Public::AppealsController < ApplicationController
  inherit_resources

  actions :create, :new, :show

  before_filter :audit, :except => :show

  private
    def audit
      Appeal.audit(request)
      p Appeal
    end
end

