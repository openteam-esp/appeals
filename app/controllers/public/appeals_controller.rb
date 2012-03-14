class Public::AppealsController < ApplicationController
  inherit_resources

  belongs_to :section

  actions :create, :new, :show

  layout 'public/appeal'

  before_filter :audit, :except => [:new, :show]

  def new
    new! do |success|
      @appeal.build_address
      success.html
      success.vnd_html { render :file => 'public/appeals/remote_form.html', :layout => false }
    end
  end

  def create
    create! do |success, failure|
      if params.has_key?('X-REQUESTED-WITH')
        success.html do
          destroy_appeal_attachemnts_path
          render :action => :show, :layout => false
        end
        failure.html { render :file => 'public/appeals/remote_form.html', :layout => false }
      else
        success.html do
          destroy_appeal_attachemnts_path
          redirect_to public_appeal_path(@appeal.code)
        end
        failure.html { render :action => :new }
      end
    end
  end

  def show
    @appeal = Appeal.find_by_code(params[:id])
  end

  private
    def audit
      Appeal.request_env = request.env
    end

    def destroy_appeal_attachemnts_path
      session[:appeal_attachemnts_path].try(:delete, params[:section_id])
    end
end

