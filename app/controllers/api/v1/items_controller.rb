class Api::V1::ItemsController < Api::V1::BaseController
    acts_as_token_authentication_handler_for User, except: [ :index, :show ]
    before_action :set_item, only: [ :show, :destroy ]
  def index
    @items = policy_scope(Item)
  end


  def show
  end

  def update
    if @item.update(item_params)
      render :show
    else
      render_error
    end
  end

    def create
    @item = Item.new(item_params)
    @item.user = current_user
    authorize @item
    if @item.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @item.destroy
    head :no_content
    # No need to create a `destroy.json.jbuilder` view
  end

  private

  def set_item
    @item = Item.find(params[:id])
    authorize @item  # For Pundit
  end

  def item_params
    params.require(:item).permit(:id, :description, :expiration, :price, :pickup_time,
                    :picture, :quantity, :user_id, :address, :category,
                    :price_cents, :distance_location)
  end

  def render_error
    render json: { errors: @item.errors.full_messages },
      status: :unprocessable_entity
  end
end
