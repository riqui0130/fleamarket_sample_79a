class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    # @item.item_images.new
    @category_parent_array = ['選択して下さい']
    @category_parent_array = Category.where(ancestry: nil)
  end

  def get_category_children
    @category_children = Category.find(params[:parent_id]).children
  end
  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: "出品しました"
    else
      render :new, alert: "出品できません。入力必須項目を確認してください"
    end
  end

  private

end
