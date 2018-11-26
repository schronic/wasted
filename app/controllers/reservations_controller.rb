class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show edit update destroy]
  # before_action :set_item, only: [:create]

  def index
    @reservations = policy_scope(Reservation).order(created_at: :desc)
    @reservation = Reservation.new
    authorize @reservation

    # CAROUSEL: OTHER UNIQUE ITEMS BY SAME SUPPLIER
    @same_supplier_items = []
    @in_cart = []
    @reservations.each do |reservation|
      @same_supplier_items |= reservation.item.user.items
      @in_cart << reservation.item
    end
    @same_supplier_items -= @in_cart

    # SHOPPING CART: SEPARATE ITEMS BY SELLER
    @reservations_suppliers = []
    @reservations.each do |reservation|
      supplier = reservation.item.user
      @reservations_suppliers |= [supplier]
    end
    @reservations_suppliers_with_reserved = @reservations_suppliers.map { |supplier|
      [
        supplier,
        @reservations
          .joins(:item)
          .where(items: { user_id: supplier.id })
      ]
    }

    if user_signed_in?
      @purchased_item = PurchasedItem.new
      @subtotal_price = 0
      @total_price = 0
      @total_items = 0
      @reservations.each do |reservation|
        @subtotal_price += reservation.item.price * reservation.quantity
        @total_items += reservation.quantity
      end
      percent = 0.05
      @commission = @subtotal_price * percent
      @amount = @subtotal_price * (1 + percent)
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
    @reservation = Reservation.new(reservation_params)
    authorize @reservation
    if @reservation.save && params.dig(:reservation, :in_cart)
      redirect_to cart_path
    elsif @reservation.save
      redirect_to items_path
    else
      redirect_to items_path
    end
  end

  def edit
  end

  def update
    @reservation.update(reservation_params)
    authorize @reservation
    if @reservation.save && params.dig(:reservation, :in_cart)
      redirect_to cart_path
    elsif @reservation.save
      redirect_to items_path
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
  #   @item = item.find(params[:reservation][:item_id])
  # end

  def reservation_params
    params.require(:reservation).permit(:quantity, :user_id, :item_id)
  end
end
