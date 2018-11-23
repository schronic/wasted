class OrdersController < ApplicationController
  before_action :set_order, only: %i[new show]
  def index
    @orders = policy_scope(Order).order(created_at: :desc)
  end

  def show
    @order = current_user.orders.where(state: 'paid').find(params[:id])
    authorize @order
  end

  def new
    authorize @order
  end

  def create
    item = Item.find(params[:item_id])
    order = Order.create!(item_sku: item.sku, amount: item.price, state: 'pending', user: current_user)

    redirect_to new_order_payment_path(order)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
