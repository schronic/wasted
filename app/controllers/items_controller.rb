class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  skip_before_action :authenticate_user!, only: %i[index show]

  # @results = Geocoder.search([current_lat, current_lng]) Enable only in production

  def index
    @current_lat = request.location.latitude
    @current_lng = request.location.longitude
    # @results = Geocoder.search([current_lat, current_lng]) Enable only in production

    if Rails.env.production?
      @results = Geocoder.search([@current_lat, @current_lng])
    else
      @results = Geocoder.search([20, 100])
    end

    @reservation = Reservation.new(quantity: 0)

    @items = policy_scope(Item).order(expiration: :desc).items_where_can_reserve_more.uniq!
    if @items.present?
      @items.each do |item|
        if Rails.env.production?
          item.update(distance_location: Geocoder::Calculations.distance_between([@current_lat, @current_lng], ([item.latitude, item.longitude])).round(2))
        else
          item.update(distance_location: Geocoder::Calculations.distance_between([0, 0], ([item.latitude, item.longitude])).round(2))
        end
        item.save
      end

      if params[:term]

        categories_clean = params[:term][:catg].drop(1) if params[:term][:catg]
        types_clean = params[:term][:types].drop(1) if params[:term][:types]

        @query = true

        if params[:term][:search].present?
          @items = @items.search_by_title_and_syllabus(params[:term][:search])
        end

        if params[:term][:query].present?
          @results = Geocoder.search(params[:term][:query])
          @items = @items.near(@results.first.address, 50)
        end

        if categories_clean.present?
          categories_clean.each do |catg|
            @items = @items.where(category: catg)
            # does that only select for the last catg?
          end
        end

        if types_clean.present?
          @types = Type.where(name: types_clean)
          bubu = []
          @types.each do |type|
            bubu << @items.joins(:features).where('features.type_id = ?', type.id)
          end
          @items = Item.where(id: bubu.flatten.map(&:id))
        end

        unless @items.present?
          @empty = true
          if user_signed_in?
            @items = policy_scope(Item).order(expiration: :desc).where.not(user_id: current_user.id)
          else
            @items = policy_scope(Item).order(expiration: :desc)
          end
        end
      end
      # raise message saying nothing found and redirect to index

      @markers = @items.map do |item|
        {
          lng: item.longitude,
          lat: item.latitude,
          infoWindow: { content: render_to_string(partial: "/items/map_window", locals: { item: item }) }
        }
      end

        @items_close = @items.sort_by(&:distance_location)
    end
  end

  def show
  end

  def new
    @item = Item.new
    @feature = Feature.new
    @types = Type.all

    authorize @item
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    authorize @item
    @item.save
    results = Geocoder.search(@item.address)
    coor = results.first.coordinates
    @item.update(latitude: coor[0], longitude: coor[1])

    params[:item][:types].each do |type|
      @type = Type.find_by(name: type)
      Feature.create(item: @item, type: @type)
    end
    redirect_to items_path
  end

  def edit
  end

  def update
    @feature = Feature.where(item: @item)
    @feature.each do |feature|
      feature.destroy
    end

    params[:item][:types].each do |type|
      @type = Type.find_by(name: type)
      Feature.create(item: @item, type: @type)
    end

    @item.update(item_params)
    @item.save
    redirect_to user_path(current_user)
  end

  def destroy
    @item.destroy
    redirect_to user_path(current_user)
  end

  private

  def set_item
    @item = Item.find(params[:id])
    authorize @item
  end

  def item_params
    params.require(:item).permit(:types, :category, :address, :description, :expiration, :name, :price, :pickup_time, :picture, :quantity, :user_id)
  end
end


#searchbar:
#searchbar by address --> turn input address into coordinates
#for every item --> turn address into coordinates
#==> order by distance_location

#filters:
#modal that moves everything down
#and then foodora like

#item.near('Tour Eiffel', 10)      # venues within 10 km of Tour Eiffel
#item.near([40.71, 100.23], 20)    # venues within 20 km of a point
#
