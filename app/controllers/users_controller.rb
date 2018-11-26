class UsersController < ApplicationController
  before_action :set_user

  def show
    authorize @user
    @orders = policy_scope(Order).order(created_at: :desc)
    @paid = @orders.where(state: 'paid')
    @pending = @orders.where(state: 'pending')
  end

  def set_user
    @user = User.find(params[:id])
  end
end
