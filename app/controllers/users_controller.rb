class UsersController < ApplicationController
  def show
    authorize current_user
  end
end
