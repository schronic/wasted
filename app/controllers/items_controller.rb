class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  skip_before_action :authenticate_user!, only: %i[index show]

# @results = Geocoder.search([current_lat, current_lng]) Enable only in production

  def index
    @current_lat = request.location.latitude
    @current_lng = request.location.longitude
    @results = Geocoder.search([-34.587880, -58.418150])
    @items = policy_scope(Item).order(created_at: :desc)

    @items.each do |item|
      item.update(distance: Geocoder::Calculations.distance_between([-34.587880, -34.587880], ([item.latitude, item.longitude])).round(2))
    end

    if params[:term]
      categories_clean = params[:term][:catg].drop(1) if params[:term][:catg]
      types_clean = params[:term][:att].drop(1) if params[:term][:att]

      @query = true

      if params[:term][:query].present?
        @results = Geocoder.search(params[:term][:query])
        @items = Item.near(params[:term][:query])
      end

      if categories_clean.present?
        categories_clean.each do |catg|
          @items = @items.where(category: catg)
        end
      end

      if types_clean.present?
        types_clean.each do |types|
          @items = @items.where(food_type: types)
        end
      end

      @items = @items.where.not(user_id: current_user)
    end

    @markers = @items.map do |item|
      {
        lng: item.longitude,
        lat: item.latitude,
        infoWindow: { content: render_to_string(partial: "/items/map_window", locals: { item: item }) }
      }
    end
  end

  def show
  end

  def new
    @item = Item.new
    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    authorize @item
    @item.save
    redirect_to items_path
  end

  def edit
    authorize @item
  end

  def update
    @item.update(item_params)
    redirect_to items_path
    @item.save
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
    authorize @item
  end

  def item_params
    params.require(:item).permit(:category, :food_type, :address, :description, :expiration, :name, :price, :pickup_time, :picture, :quantity, :user_id)
  end
end


#searchbar:
#searchbar by address --> turn input address into coordinates
#for every item --> turn address into coordinates
#==> order by distance

#filters:
#modal that moves everything down
#and then foodora like

#item.near('Tour Eiffel', 10)      # venues within 10 km of Tour Eiffel
#item.near([40.71, 100.23], 20)    # venues within 20 km of a point
#
