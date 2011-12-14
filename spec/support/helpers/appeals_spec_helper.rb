# encoding: utf-8

module AppealsSpecHelper
  def current_user
    @current_user
  end

  def set_current_user(user = nil)
    user ||= create_user
    @current_user = user
  end

  def as(user, &block)
    logged_in = current_user
    set_current_user user
    result = yield
    set_current_user logged_in
    result
  end

  def create_user(options={})
    Fabricate(:user, options)
  end

  def user(options={})
    @user ||= create_user(options)
  end

  def create_fresh_appeal(options={})
    Fabricate(:appeal, options)
  end

  def create_registered_appeal(options={})
    registration_options = options.delete(:registration) || {}
    create_fresh_appeal(options).tap do |appeal|
      appeal.create_registration Fabricate.attributes_for(:registration, registration_options)
      appeal.reload
    end
  end

  def create_noted_appeal(options={})
    note_options = options.delete(:note) || {}
    create_registered_appeal(options).tap do |appeal|
      appeal.create_note Fabricate.attributes_for(:note, note_options)
      appeal.reload
    end
  end

  def create_redirected_appeal(options={})
    redirect_options = options.delete(:redirect) || {}
    create_registered_appeal(options).tap do |appeal|
      appeal.create_redirect Fabricate.attributes_for(:redirect, redirect_options)
      appeal.reload
    end
  end

  def create_reviewing_appeal(options={})
    review_options = options.delete(:review) || {}
    create_registered_appeal(options).tap do |appeal|
      appeal.create_review Fabricate.attributes_for(:review, review_options)
      appeal.reload
    end
  end

  def fresh_appeal(options={})
    @fresh_appeal ||= create_fresh_appeal(options)
  end

  def registered_appeal(options={})
    @registered_appeal ||= create_registered_appeal(options)
  end

  def noted_appeal(options={})
    @noted_appeal ||= create_noted_appeal(options)
  end

  def redirected_appeal(options={})
    @redirected_appeal ||= create_redirected_appeal(options)
  end

  def reviewing_appeal(options={})
    @reviewing_appeal ||= create_reviewing_appeal(options)
  end

  def closed_appeal(options={})
    @closed_appeal ||= reviewing_appeal.tap do |appeal|
      appeal.reply.update_attributes Fabricate.attributes_for(:reply)
      appeal.to_close!
    end
  end

  def deleted_appeal(options={})
    @deleted_appeal ||= closed_appeal.tap do |appeal|
      appeal.move_to_trash_by(current_user)
    end
  end

  def restored_appeal(options={})
    @restored_appeal ||= deleted_appeal.tap do |appeal|
      appeal.restore
    end
  end
end

