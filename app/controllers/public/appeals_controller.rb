class Public::AppealsController < ApplicationController
  inherit_resources

  belongs_to :section, :finder => :find_by_slug

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
        success.html { render :action => :show, :layout => false }
        failure.html { render :file => 'public/appeals/remote_form.html', :layout => false }
      else
        success.html { redirect_to public_appeal_path(@appeal.code) }
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
end

