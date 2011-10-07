class Ability
  include CanCan::Ability

  def initialize(user=nil)
    user ||= (User.current || User.new)

    unless user.new_record?
      can :manage, Registration
    end
  end
end
