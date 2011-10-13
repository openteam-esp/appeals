class Public::AppealsController < ApplicationController
  inherit_resources

  actions :create, :new, :show

  layout 'public/appeal'

  before_filter :audit, :except => [:new, :show]

  def new
    new! {
      @appeal.build_address
    }
  end

  def create
    create! { |success, failure|
      success.html {
        @appeal.uploads = uploads
        session.delete(:upload_ids)
        redirect_to public_appeal_path(@appeal.code)
      }
    }
  end

  def show
    @appeal = Appeal.find_by_code(params[:id])
  end

  private
    def audit
      Appeal.request_env = request.env
    end
end

