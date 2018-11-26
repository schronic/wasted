class UsersController < ApplicationController
  def show
    @item = Item.new
    authorize current_user
  end

end
