# encoding: utf-8

class CheckStatusesController < ApplicationController
  layout 'public/appeal'

  def new
    @check_status = CheckStatus.new
  end

  def create
    @check_status = CheckStatus.new(params[:check_status])

    if @appeal = Appeal.find_by_code(@check_status.code)
      redirect_to public_appeal_path @appeal.code
    else
      @check_status.errors[:base] << t('errors.messages.appeal_not_found') if @check_status.valid?

      render :new
    end
  end
end

