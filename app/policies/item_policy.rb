class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve

      if user_logged_in?
        scope.where.not(user_id: user.id)
      else
        scope.all
      end
    end

    def user_logged_in?
      user
    end
  end

  def show?
    true
  end

  def new?
    supplier?
  end

  def create?
    new?
  end

  def edit?
    current_user?
  end

  def update?
    edit?
  end

  def destroy?
    current_user?
  end

  private

  def current_user?
    record.user == user
  end
end
