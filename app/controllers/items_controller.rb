class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @items = policy_scope(Item).order(created_at: :desc)
    if params[:query].present?
      @items = Item.near(params[:query])
    elsif params[:term]
      PgSearch::Multisearch.rebuild(Item)

      categories_clean = params[:term][:catg].drop(1).join(" ")
      types_clean = params[:term][:att].drop(1).join(" ")

      results = PgSearch.multisearch(params[:categories])
raise
# (Select * where category is any of the selected ). select * where attri fit any of the preselected

      @items = []
      results.each do |result|
        @items << (result.searchable)
      end
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

#Flat.near('Tour Eiffel', 10)      # venues within 10 km of Tour Eiffel
#Flat.near([40.71, 100.23], 20)    # venues within 20 km of a point
#
