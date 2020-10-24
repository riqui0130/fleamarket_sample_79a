class ItemsController < ApplicationController
  def index
    @items = Item.all.limit(5)
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
  end

  def new
    @item = Item.new
    @item.pictures.build
  end
  
  def buy
  end
  
end
