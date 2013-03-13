class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :application do
      user.permissions.any?
    end

    can :manage, :all if user.manager?

    ## app specific
    can :manage, Appeal do |appeal|
      user.operator_of? appeal.section
    end

    can :manage, [Note, Registration, Redirect, Review, Reply] do |object|
      can? :manage, object.appeal
    end

    can :manage, KremlinAppeal
  end
end
