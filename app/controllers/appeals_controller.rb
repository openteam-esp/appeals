class AppealsController < ApplicationController
  inherit_resources

  actions :create, :new, :show

  belongs_to :section

  layout 'public/appeal'

  before_filter :audit, :except => [:new, :show]

  def new
    new! do |success|
      @appeal.build_address
      success.html
      success.vnd_html { render :file => 'appeals/remote_form.html', :layout => false }
    end
  end

  def create
    create! do |success, failure|
      if params.has_key?('X-REQUESTED-WITH')
        success.html do
          destroy_appeal_attachemnts_path
          render :action => :show, :layout => false
        end
        failure.html { render :file => 'appeals/remote_form.html', :layout => false }
      else
        success.html do
          destroy_appeal_attachemnts_path
          redirect_to appeal_path(@appeal.code)
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

