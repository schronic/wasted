class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]
  # before_action :set_item, only: [:create]
  skip_before_action :authenticate_user!, only: %i[index show new create edit update destroy]

  def index
    @reservations = policy_scope(Reservation).order(created_at: :desc)
    if user_signed_in?
      @purchased_item = PurchasedItem.new
      @subtotal_price = 0
      @total_price = 0
      @total_items = 0
      @reservations.each do |reservation|
        @subtotal_price += reservation.item.price
        @total_items += 1
      end
      percent = 0.05
      @commission = @subtotal_price * percent
      @total_price = @subtotal_price * (1 + percent)
      @amount_cents = @total_price * 100
    else
      redirect_to reservations_error_path
    end
  end

  def show
  end

  def new
    @reservation = current_user.reservations.new
    authorize @reservation
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    authorize @reservation
    if @reservation.save
      redirect_to items_path
    else
      render html: "<h1>You received the following error:</h1>
      <h3><em>#{@reservation.errors.full_messages}</em></h3>".html_safe
    end
  end

  def edit
  end

  def update
    @reservation.update(reservation_params)
    if @reservation.save
      redirect_to @reservation
    else render :edit
    end
  end

  def destroy
    @reservation.destroy
    @reservations = Reservation.all
    if params.dig(:reservation, :in_cart) && @reservations.any? # == 'true' (not a boolean in params)
      redirect_to cart_path
    else
      redirect_to items_path
    end
    # split with if/else based on where you were when removed from cart
    # redirect_to cart_path
  end

  def error
  end

private

  def set_reservation
    @reservation = Reservation.find(params[:id])
    authorize @reservation
  end

  # def set_item
  #   @item = item.find(params[:reservation[:item_id]])
  # end

  def reservation_params
    params.require(:reservation).permit(:item_id, :user_id)
  end
end
