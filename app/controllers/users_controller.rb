class UsersController < ApplicationController
  before_action :set_user

  def show
    authorize @user
    @orders = policy_scope(Order).order(created_at: :desc)
    @paid = @orders.where(state: 'paid')
    @pending = @orders.where(state: 'pending')

    @items = Item.where(user: current_user)

    @items_bought = []
    @items_pending = []

    @items.each do |item|
      reservation = Reservation.find_by(item: item)
      if reservation.present?

        if reservation.purchased_item_id == nil
          @items_pending << item
        else
          purchase = PurchasedItem.find_by(item: item)
          buyer_id = Order.find(purchase.order.id).user_id
          buyer = User.find(buyer_id)
          @items_bought << [item, buyer]
        end
      else
        @items_pending << item
      end
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end


