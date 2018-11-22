class ReservationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if consumer?
        scope.where(user_id: user.id)
      else
        false
      end
    end
  end

  def create?
    consumer?
  end

  def edit?
    consumer?
  end

  def update?
    edit?
  end

  def destroy?
    consumer?
  end

  def error?
    true
  end
end
