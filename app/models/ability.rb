class Ability
  include CanCan::Ability

  def initialize(user)
    # can :access, ActiveAdmin::Page, name: "Dashboard", namespace_name: :admin
    user ||= User.new # guest user (not logged in)
    if user.persisted?
      can :read, [Book, Author, OrderStatus, Delivery, Coupon]
      can :read, Review
      can :create, Review
      can %i[read create update], [Order, Address, CreditCard, Cart], user_id: user.id
      can :manage, OrderItem
      can :manage, User, id: user.id
    else
      can :read, Review
      can :read, [Book, Author]
      can %i[create read update], Order
      can :manage, OrderItem
    end

  end

end
