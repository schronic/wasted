class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @items = policy_scope(Item).order(created_at: :desc)
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
  end

  def update
    @item.update(item_params)
    redirect_to items_path
  end

  def destroy
    @item.destroy
    redirect_to friends_path
  end

  private

  def set_item
    @item = Item.find(params[:id])
    authorize @item
  end

  def item_params
    params.require(:item).permit(:description, :expiration, :name, :price, :pickup_time, :picture, :quantity, :user_id)
  end
end
