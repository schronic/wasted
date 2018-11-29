class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user_logged_in?
        scope.joins(:reservations)
             .where('pickup_time > ?', Time.now)
             .where('items.quantity > ?', 0)
             .where.not(items: { user_id: user.id })

        # scope.where.not(id: Reservation.where(user_id: user.id)
        #                                .pluck(:item_id))
        #      .where.not(user_id: user.id)
        #      .where('pickup_time > ?', Time.now)
        #      .where('quantity > ?', 0)
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
