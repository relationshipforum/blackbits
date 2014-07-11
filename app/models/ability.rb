class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Post, :author_id => user.id
    can :manage, Post if user.admin?
  end
end
