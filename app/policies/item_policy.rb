class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve

      # Don't show items uploaded by the user (supplier), OR in the user's cart (consumer)
      if user_logged_in?
        # scope.where.not(id: Reservation.where(user_id: user.id)
        #                                .pluck(:item_id))
        #      .where.not(user_id: user.id)
        #      .where('pickup_time > ?', Time.now)
        #      .where('quantity > ?', 0)
        # Item.each do |i|
        #   scope i, -> { where(size: s) }
        # end

        scope.joins(:reservations)
             .where('pickup_time > ?', Time.now)
             .where('items.quantity > ?', 0)
             .where.not(items: { user_id: user.id })
             # .find_each do |i|
             #   (( "reservation.quantity <= ?") i.quantity )
             # end
             # .where.not(reservations: { user_id: user.id })
        # .merge
        # .where()
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
