class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user ||= User.new

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
      can %i[read index show], CustomerOrder
      cannot :cancel, CustomerOrder
    end

    def customer_permissions
      can :read, Product
      can %i[read cancel], CustomerOrder, user_id: @user.id
    end
end
