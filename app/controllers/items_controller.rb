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
    @parents = Category.where(ancestry: nil)  
  end

  def create
    @item = Item.new(item_params)
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :prefecture_id, :seller_id,
    :buyer_id, :condition_id, :category_id, :size_id, :shipping_fee_id,
     :delivery_days_id, :brand_id,
     pictures_attributes: [:src, :_destroy, :id]).merge(seller_id: current_user.id)
  end

  def set_items
    @item = Item.includes(:seller,:category).find(params[:id])
  end

  def set_categories
    @parents = Category.where(ancestry: nil)
  end
end
