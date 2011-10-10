class Public::AppealsController < ApplicationController
  inherit_resources

  actions :create, :new, :show

  before_filter :audit, :except => :show

  def new
    new! { @appeal.build_address }
  end

  private
    def audit
      Appeal.audit(request)
    end
end

