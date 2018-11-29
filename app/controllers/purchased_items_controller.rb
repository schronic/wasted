class PurchasedItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    if params[:subaction].present?
      @reservation = Reservation.new
      @reservation.item_id = params[:reservation][:item_id]
      @reservation.quantity = params[:reservation][:quantity]
      @reservation.user = current_user

      authorize @reservation

      if Reservation.find_by(item: @reservation.item).present?
        Reservation.find_by(item: @reservation.item).destroy
      end
      @reservation.save
      @amount = params[:subaction] * @reservation.quantity * 1.05
raise
      @order = Order.new(
        amount: @amount.to_i,
        user_id: current_user.id,
        state: 'pending',
        total_price: @reservation.item.price
        )
      authorize @order

      render html: "<h3><em>#{@order.errors.full_messages}</em></h3>".html_safe unless @order.save
      @purchased_items = []
      purchased_item = PurchasedItem.new(
        item_purchase_price: @reservation.item.price,
        item_purchase_quantity: @reservation.quantity,
        item_id: @reservation.item.id,
        order_id: @order.id,
        item_purchase_name: @reservation.item.name,
        item_purchase_description: @reservation.item.description,
        item_purchase_expiration: @reservation.item.expiration,
        item_purchase_pickup_time: @reservation.item.pickup_time,
        item_purchase_picture: @reservation.item.picture
      )
      render html: "<h3><em>#{purchased_item.errors.full_messages}</em></h3>".html_safe unless purchased_item.save
      @purchased_items << purchased_item
      @reservation.item.quantity -= @reservation.quantity
      @reservation.item.save
      @reservation.destroy
    redirect_to new_order_payment_path(@order)

    elsif

     @reservations.any? && !params[:subaction].present?
      @order = Order.new(
        amount: 7,
        user_id: current_user.id,
        state: 'pending'
      )
      authorize @order
      render html: "<h3><em>#{@order.errors.full_messages}</em></h3>".html_safe unless @order.save

      @purchased_items = []
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
        render html: "<h3><em>#{purchased_item.errors.full_messages}</em></h3>".html_safe unless purchased_item.save
        @purchased_items << purchased_item
        reservation.item.quantity -= reservation.quantity
        reservation.item.save
        reservation.destroy
      end
      redirect_to new_order_payment_path(@order)
    else
      authorize @reservations
      sleep(5)
      redirect_to cart_path
    end
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

  def amount_params
    params.require(:amount)
  end

    def reservation_params
    params.require(:reservation).permit(:amount, :item_id, :quantity)
  end
end
