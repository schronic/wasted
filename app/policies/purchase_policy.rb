class PurchasePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: current_user.id)
    end
  end

  def show?
    user.record == user
  end

  def new?
    user.role == 'consumer'
  end

  def create?
    new?
  end
end
