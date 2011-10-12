class Ability
  include CanCan::Ability

  def initialize(user=nil)
    user ||= (User.current || User.new)

    unless user.new_record?
      can :manage, Registration

      can :read, Appeal

      can :update, Reply do |reply|
        !reply.appeal.closed?
      end
    end
  end
end
