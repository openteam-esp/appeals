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
    @fresh_appeal ||= Fabricate(:appeal)
  end

  def registred_appeal(options={})
    @registred_appeal ||= fresh_appeal.tap do |appeal|
      appeal.create_registration Fabricate.attributes_for(:registration)
      appeal.reload
    end
  end
end

