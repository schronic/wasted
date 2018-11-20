class OrdersController < ApplicationController
  def index
  end

  def show
    @order = current_user.orders.where(state: 'paid').find(params[:id])
  end

  def new
  end

  def create
    item = Item.find(params[:item_id])
    order = Order.create!(item_sku: item.sku, amount: item.price, state: 'pending', user: current_user)

    redirect_to new_order_payment_path(order)
  end
end
