class ItemsController < ApplicationController
  before_action :set_current_user_items,only:[:i_transaction,:i_exhibiting,:i_soldout]

  def index
    @items = Item.all.limit(5)
  end

  def show
  end


  def new
    if user_signed_in?
      @item = Item.new
      # @item.item_pictures.build
      @category_parent_array = Category.where(ancestry: nil)
    else
      redirect_to root_path, notice: 'ログインもしくはサインインしてください'
    end
  end

  def create
    @item = Item.new(@item_params)
    # if @item.save
      render :sell
    # else
    #   render :new
    # end
  end

  def i_exhibiting #出品中のアクション
  end

  def i_transaction  #取引中のアクション
  end

  def i_soldout    #売却済みのアクション
  end

  private

  def set_items
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :status_id, :postage_id, :prefecture_id, :days_id, :price, :images [])
  end

  def set_current_user_items
    if user_signed_in? 
      @items = current_user.items.includes(:seller,:buyer,:auction,:item_images)
    else
      redirect_to root_path
    end
  end
end
