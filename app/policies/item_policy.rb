class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve

      # Don't show items uploaded by the user (supplier), OR in the user's cart (consumer)
      if user_logged_in?
        scope.where.not(id: Reservation
            .where(user_id: user.id)
            .pluck(:item_id))

        # scope.joins(:reservations)
        #      .where.not(reservations: { user_id: user.id })
        #      .where.not(items: { user_id: user.id })
      else
        scope.all
      end
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
