class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)
    
    if user.role == "Admin"
        can :manage, :all
    elsif user.role == "Editor"
        can :manage, Document
        can :create, Document
        can :edit, Document
    elsif user.role == "Accessor"
        can :read, Document
    end
  end
end
