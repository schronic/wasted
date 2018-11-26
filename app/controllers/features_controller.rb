class FeaturesController < ApplicationController

  def index

  end
  def create
    @feature = Feature.new(strong_params)
    @feature[:item_id] = params[:item_id]
    @item = Item.find(params[:item_id])
    return redirect_to @item if @feature.save
    redirect_to @item
  end

  def destroy
    @feature = Feature.find(params[:id])
    @feature.delete
    @item = Item.find(params[:item_id])
    redirect_to @item
  end

  private

  def strong_params
    params.require(:feature).permit(:item_id, :ingredient_id)
  end
end
