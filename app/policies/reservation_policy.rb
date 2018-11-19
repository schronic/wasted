class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user_role?
  end

  def edit?
    user_role?
  end

  def update?
    edit?
  end

  def destroy?
    user_role?
  end

  private

  def user_role?
    user.role == 'consumer'
  end
end
