class Public::AppealsController < ApplicationController
  inherit_resources

  actions :create, :new, :show

  layout 'public/appeal'

  before_filter :audit, :except => [:new, :show]

  def new
    @appeal = Appeal.new
    @appeal.build_address
    respond_to do |format|
      format.html
      format.vnd_html { render :file => 'public/appeals/new.html', :layout => false }
    end
  end

  def create
    @appeal = Appeal.new(params[:appeal])

    if @appeal.save
      @appeal.uploads = uploads
      session.delete(:upload_ids)
      if params.has_key?('X-REQUESTED-WITH')
        render :action => :show, :layout => false
      else
        redirect_to public_appeal_path(@appeal.code)
      end
    else
      if params.has_key?('X-REQUESTED-WITH')
        render :action => :new, :layout => false
      else
        render :action => :new
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

