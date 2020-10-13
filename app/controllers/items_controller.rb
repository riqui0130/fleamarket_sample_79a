class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    # @item.images.new
    @category_parent_array = []
    # @category = Category.roots.each do |parent|
    # @category_parent_array << parent.name
    # end
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
