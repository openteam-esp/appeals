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
    Fabricate(:appeal).tap do |appeal|
      appeal.dispatch!
    end
  end

  def registred_appeal(options={})
    @registred_appeal ||= create_registred_appeal(options)
  end

  def create_registred_appeal(options={})
    create_fresh_appeal.tap do | appeal |
      Fabricate(:registration, :appeal => appeal)
      appeal.reload
    end
  end
end

