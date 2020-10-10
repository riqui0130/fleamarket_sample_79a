class ItemsController < ApplicationController
  def index
    @items = Item.all.limit(5)
  end

  def show
  end

  def new
    @item = Item.new
  end
  
end
