class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user_id: user.id)
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

  def destroy?
    record.state == 'pending' && consumer?
  end
end
