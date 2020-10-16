class CategoriesController < ApplicationController
  before_action :category_parent_array
  before_action :set_category

  def grandchild
    @items = Item.where(category_id: params[:id]).order('created_at DESC').limit(30)
  end

  def child
    grandchildren = @category.children
    @items = []
    grandchildren.each do |grandchild|
      @items += Item.where(category_id: grandchild.id).order('created_at DESC').limit(30)
    end
  end

  def parent
    children = @category.children
    grandchildren = []
    children.each do |child|
      grandchildren << Category.where(ancestry: "#{@category.id}/#{child.id}")
    end
    @items = []
    grandchildren.each do |grandchild|
      grandchild.each do |id|
        @items += Item.where(category_id: id).order('created_at DESC').limit(30)
      end
    end
  end
  
  private
  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
