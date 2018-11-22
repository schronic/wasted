class PurchasedItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: current_user.id)
    end
  end

  def show?
    record.user == user
  end

  def new?
    consumer?
  end

  def create?
    new?
  end
end
