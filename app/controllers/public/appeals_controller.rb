class Public::AppealsController < ApplicationController
  inherit_resources

  actions :create, :new, :show

  before_filter :audit, :except => :show

  def new
    new! { @appeal.build_address }
  end

  def create
    create! { public_appeal_path(@appeal.code) }
  end

  def show
    @appeal = Appeal.find_by_code(params[:id])
  end

  private
    def audit
      Appeal.audit(request)
    end
end

