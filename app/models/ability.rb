class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      user_permissions(user)
    end
  end

  private
    def user_restaurant_permissions
      can [:create, :read, :update, :destroy], Product
    end

    def user_customer_permissions
      can :read, Product
    end

    def user_permissions(user)
      if user.restaurant?
        user_restaurant_permissions
      elsif user.customer?
        user_customer_permissions
      else
        cannot :manage, :all
      end
    end
end
