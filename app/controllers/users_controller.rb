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
      purchase = PurchasedItem.find_by(item: item)
      if purchase.present?

         if purchase.order.state == 'pending'
          @items_pending << item
        elsif purchase.order.state == 'paid'
          buyer = purchase.order.user
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

