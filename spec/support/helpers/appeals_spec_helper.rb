# encoding: utf-8

module AppealsSpecHelper
  def set_current_user(user = nil)
    user ||= create_user
    User.current = user
  end

  def as(user, &block)
    logged_in = User.current
    User.current = user
    result = yield
    User.current = logged_in
    result
  end

  def user(options={})
    @user ||= create_user(options)
  end

  def create_user(options={})
    Fabricate(:user, options)
  end

  def fresh_appeal(options={})
    @fresh_appeal ||= create_fresh_appeal(options)
  end

  def create_fresh_appeal(options={})
    Fabricate(:appeal, options)
  end

  def registered_appeal(options={})
    @registered_appeal ||= create_registered_appeal(options)
  end

  def create_registered_appeal(options={})
    registration_options = options.delete(:registration) || {}
    create_fresh_appeal(options).tap do |appeal|
      appeal.create_registration Fabricate.attributes_for(:registration, registration_options)
      appeal.reload
    end
  end

  def closed_appeal(options={})
    @closed_appeal ||= registered_appeal.tap do |appeal|
      Fabricate(:reply, :appeal => appeal)
      appeal.close!
    end
  end

  def deleted_appeal(options={})
    @deleted_appeal ||= closed_appeal.tap do |appeal|
      appeal.destroy
    end
  end

  def restored_appeal(options={})
    @restored_appeal ||= deleted_appeal.tap do |appeal|
      appeal.restore
    end
  end
end

