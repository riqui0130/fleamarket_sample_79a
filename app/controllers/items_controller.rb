class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :currect_user_item]
  before_action :currect_user_item, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:images).order(created_at: "desc")
    @parents = Category.where(ancestry: nil)
  end

  def show
    @parents = Category.where(ancestry: nil)
    @item = Item.find(params[:id])
    @category = Category.find(@item.category_id)
    @user = User.find(@item.seller_id)
    @condition = Condition.find(@item.condition_id)
    @prefecture = Prefecture.find(@item.prefecture_id)
    @delivery_days = DeliveryDays.find(@item.delivery_days_id)
    @delivery_cost = Deliverycost.find(@item.deliverycost_id)
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
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
      @item.images.build
      render '/items/sell'
    else
      render :new
    end
  end


  require 'payjp'

  def buy
    #商品送付先情報の変数設定
    @destination = Destination.find_by(id: current_user.id)
    #商品情報の変数設定
    @item = Item.find(params[:id])
    #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    card = Creditcard.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_ACCESS_KEY"]
      #保管した顧客IDでpayjpから情報取得
      customer = Payjp::Customer.retrieve(card.customer_id)
      #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
      @default_card_information = customer.cards.retrieve(card.card_id)
    end


  end
  
  def pay
    @item = Item.find(params[:id])
    card = Creditcard.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_ACCESS_KEY']
    Payjp::Charge.create(
    :amount => @item.price, #支払金額を入力（itemテーブル等に紐づけても良い）
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
    )
    @item_buyer= Item.find(params[:id])
    @item_buyer.update( buyer_id: current_user.id)
  
    redirect_to action: 'done' #完了画面に移動
  end

  def done
  end
  def edit
    @parents = Category.where(ancestry: nil)
    @category = Category.find(@item.category_id)
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: '更新しました'
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

  def set_item
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

