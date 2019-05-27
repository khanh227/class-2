class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case
    when user.admin?
      can :manage, :all
    when user.restaurant?
      restaurant_permissions
    when user.customer?
      customer_permissions
    else
      cannot :manage, :all
    end
  end

  private
    def restaurant_permissions
      can [:create, :read, :update, :destroy], Product
      can [:read, :index, :show], CustomerOrder
      cannot :cancel, CustomerOrder
    end

    def customer_permissions
      can :read, Product
      can [:read, :cancel], CustomerOrder
    end
end
