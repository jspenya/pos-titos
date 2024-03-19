class StockPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.admin? || user.stockman?
  end

  def show?
    user.admin?
  end

  def new?
    user.admin? || user.stockman?
  end

  def create?
    user.admin? || user.stockman?
  end

  def edit?
    user.admin? || user.stockman?
  end

  def update?
    user.admin? || user.stockman?
  end

  def destroy?
    user.admin? || user.stockman?
  end
end
