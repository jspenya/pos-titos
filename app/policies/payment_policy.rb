class PaymentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.admin?
        scope.all
      elsif user.cashier?
        scope.where(user_id: user.id)
      end
    end
  end

  def index?
    user.admin? || user.cashier?
  end

  def new?
    user.admin? || user.cashier?
  end

  def create?
    user.admin? || user.cashier?
  end
end
