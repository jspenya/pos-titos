class ChartPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def index?
    user.admin?
  end

  def sales_all_time?
    user.admin?
  end

  def products_sold?
    user.admin?
  end

  def products_sold_this_week?
    user.admin?
  end

  def orders?
    user.admin?
  end

  def order_types?
    user.admin?
  end
end
