class Ability
  include CanCan::Ability

  def initialize(user=nil)
    user ||= (User.current || User.new)

    unless user.new_record?
      can :manage, Registration

      can [:close, :read, :restore, :revert, :review], Appeal

      can :create, [Note, Redirect, Review] do |object|
        object.appeal.registered?
      end

      can [:create, :update], Reply do |reply|
        reply.appeal.reviewing?
      end
    end

    can :manage, Upload
  end
end
