class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    ## common
    can :manage, Context do | context |
      user.manager_of? context
    end

    can :manage, Permission do | permission |
      permission.context && user.manager_of?(permission.context)
    end

    can [:new, :create], Permission do | permission |
      !permission.context && user.manager?
    end

    can [:search, :index], User do
      user.manager?
    end

    can :manage, :application do
      user.have_permissions?
    end

    can :manage, :permissions do
      user.manager?
    end

    ## app specific
    can :manage, Section do | section |
      user.manager_of? section.context
    end

    can :manage, Section do | section |
      user.operator_of? section.context
    end

    can :manage, Section do | section |
      user.manager_of? section
    end

    can :manage, Section do | section |
      user.operator_of? section
    end

    can :manage, Appeal do | appeal |
      can? :manage, appeal.section
    end
  end
end
