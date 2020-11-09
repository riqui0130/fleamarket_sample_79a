class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :edit, :update, :destroy, :currect_user_item]
  before_action :currect_user_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:images).order(created_at: "desc")
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @category = Category.find(@item.category_id)
  end

  def new
    if user_signed_in?
      @item = Item.new
      @item.images.build
      @parents = Category.where(ancestry: nil)
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.id == @item.seller_id && @item.destroy
      redirect_to root_path, notice: "商品を削除しました"
    else
      flash.now[:alert] = '商品の削除に失敗しました'
      redirect_to root_path
    end
  end

  def get_category_children
    @category_children = Category.where('ancestry = ?', "#{params[:parent_name]}")
  end
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @item = Item.new(item_params)
    @parents = Category.where(ancestry: nil)
    if @item.save
      render '/items/sell'
    else
      render :new
    end
  end

  def edit
    grandchild_category = @item.category
    child_category = grandchild_category.parent
    @parents = []
    Category.where(ancestry: nil).each do |parent|
      @parents << parent
    end
    @category_children = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children << children
    end
    @category_grandchildren = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren << grandchildren
    end
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      grandchild_category = @item.category
    child_category = grandchild_category.parent
    @parents = []
    Category.where(ancestry: nil).each do |parent|
      @parents << parent
    end
    @category_children = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children << children
    end
    @category_grandchildren = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren << grandchildren
    end

      render :edit
    end
  end


  private

  def set_categories
    @parents = Category.where(ancestry: nil)
    if user_signed_in?
      @item = Item.new
      @item.images.build
    else
      redirect_to root_path, notice: 'ログインもしくはサインインしてください'
    end
  end

  def set_items
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :detail, :category_id, :condition_id, :delivery_days_id, :prefecture_id, :deliverycost_id, :price, images_attributes: [:image, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def currect_user_item
    if current_user.id != @item.seller_id
      redirect_to item_path(params[:id])
    end
  end
end

