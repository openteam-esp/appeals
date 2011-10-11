class Public::CheckStatusesController < ApplicationController
  def new
    @check_status = CheckStatus.new
  end

  def create
    @check_status = CheckStatus.new(params[:check_status])

    if @appeal = Appeal.find_by_code(@check_status.code)
      redirect_to public_appeal_path @appeal.code
    else
      render :new
    end
  end
end

