class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
      cannot :destroy, User do |user|
        user.admin?
      end
    elsif user.manager?
      can :manage, :all
      cannot :destroy, [User, Borrow]
    else
      can :read, :all
      can [:update, :destroy], User, id: user.id
      can :destroy, [Like, Comment, Follow], user_id: user.id
      can :update, Borrow, user_id: user.id
    end
  end
end
