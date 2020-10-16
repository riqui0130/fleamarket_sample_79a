class ItemsController < ApplicationController
  before_action :set_category, only: [:new, :edit, :create, :update, :destroy]
  def index
  end

  def show
  end

  def new
    @item = Item.new
    # @item.images.new
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end
  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, alert: "出品しました"
    else
      render :new, alert: "出品できません。入力必須項目を確認してください"
    end
  end

  private

  def set_category 
    @category_parent_array = Category.where(ancestry: nil)
  end

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :status_id, :postage_id, :prefecture_id, :shippingday_id, :price, images: [])
  end

end
