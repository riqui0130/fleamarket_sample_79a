class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :edit, :update, :destroy, :set_currect_user_items]
  before_action :set_current_user_items,only:[:edit, :update, :destroy]

  def index
    @item = Item.all.includes(:image).limit(5)
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @category = Category.find(@item.category_id)
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.image.build
      @parents = Category.where(ancestry: nil)
    else
      redirect_to root_path
  end
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    @parents = Category.where(ancestry: nil)
    if @item.save!
      render :sell
    else
      render :new
    end
  end

  private

  def set_categories
    @parents = Category.where(ancestry: nil)
    if user_signed_in?
      @item = Item.new
      @item.image.build
    else
      redirect_to root_path, notice: 'ログインもしくはサインインしてください'
    end
  end

  def set_items
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :delivery_days_id, :prefecture_id, :deliverycost_id, :price, item_images_attributes: [:image])
  end

  def set_current_user_items
    if user_signed_in? 
      @item = current_user.items.includes(:seller,:buyer,:auction,:item_images)
    else
      redirect_to root_path
    end
  end
end
