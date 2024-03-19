class CustomerOrderPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.admin? || user.cashier?
  end

  def tables?
    user.admin? || user.cashier?
  end

  def individual_orders?
    user.admin? || user.cashier?
  end

  def new?
    user.admin? || user.cashier?
  end
end
