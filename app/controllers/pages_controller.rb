class PagesController < ApplicationController
  def home
    @items = Item.all
  end
end
