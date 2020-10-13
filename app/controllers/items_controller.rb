class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    # @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

end
