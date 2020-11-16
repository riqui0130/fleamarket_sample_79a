class UsersController < ApplicationController
  before_action :set_parents, only: [:show, :destroy]

  def show
    @items_sell_count = Item.where(seller_id: current_user.id).count
    @items_buy_count = Item.where(buyer_id: current_user.id).count
  end

  def destroy
  end

  private
  def set_parents
    @parents = Category.where(ancestry: nil) 
  end

end
