class ItemsController < ApplicationController
  before_action :set_items, only: [:show, :edit, :update, :destroy, :set_currect_user_items]
  before_action :set_current_user_items,only:[:edit, :update, :destroy]

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
    @parents = Category.where(ancestry: nil)  
  end

  def create
    # binding.pry
    @item = Item.new(item_params)
    @category_parent_array = Category.where(ancestry: nil)
    if @item.save
      render :sell, notice: '出品しました'
    else
      render :new
    end
  end
  
  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def set_categories
    @parents = Category.where(ancestry: nil)
    if user_signed_in?
      @item = Item.new
      @item.item_pictures.build
      @category_parent_array = Category.where(ancestry: nil)
    else
      redirect_to root_path, notice: 'ログインもしくはサインインしてください'
    end
  end

  def set_items
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :detail, :condition_id, :delivery_days_id, :prefecture_id, :deliverycost_id, :price, :images)  #後からつける:category_id,
  end

  def set_current_user_items
    if user_signed_in? 
      @items = current_user.items.includes(:seller,:buyer,:auction,:item_images)
    else
      redirect_to root_path
    end
  end
end
