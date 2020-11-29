# class FavoritesController < ApplicationController
#   before_action :set_item
#   before_action :authenticate_user!

#   def create
#     if @item.user_id != current_user.id
#       @favorite = Favorite.create(user_id: current_user.id, item_id: @item.id)
#     end
#   end

#   def destroy
#     @favorite = Favorite.find(user_id: current_user.id, item_id: @item.id)
#     @favorite.delete
#   end

#   private
#   def set_item
#     @item = Item.find(params[:item_id])
#   end
# end
