class CategoriesController < ApplicationController
  before_action :set_category
  before_action :chose_category, only: :show

  def index
  end

  def show
  end

  private
  def set_category
    @parents = Category.where(ancestry: nil).order("id ASC")
  end

  def chose_category
    @category = Category.find(params[:id])
  end

end