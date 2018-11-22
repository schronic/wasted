class PurchasedItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    @order = Order.new(
      total_price: amount_cents_params,
      user_id: current_user.id,
      amount_cents: amount_cents_params
      )
    authorize @order
    render html: "<h3><em>#{@order.errors.full_messages}</em></h3>".html_safe unless @order.save

    @reservations.each do |reservation|
      purchased_item = PurchasedItem.new(
        item_purchase_price: reservation.item.price,
        item_purchase_quantity: reservation.quantity,
        item_id: reservation.item.id,
        order_id: @order.id,
        item_purchase_name: reservation.item.name,
        item_purchase_description: reservation.item.description,
        item_purchase_expiration: reservation.item.expiration,
        item_purchase_pickup_time: reservation.item.pickup_time,
        item_purchase_picture: reservation.item.picture
      )
    authorize purchased_item
    render html: "<h3><em>#{purchased_item.errors.full_messages}</em></h3>".html_safe unless purchased_item.save
    end
    redirect_to new_order_path(@order.id, id: @order.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def reservations_params
    params.require(:reservations)
  end

  def amount_cents_params
    params.require(:amount_cents)
  end
end
