class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    category
  end

  def new
    @category = Category.new
  end

  def edit
    category
  end

  def create
    @category = Category.new(category_params)
    @category.save ? (redirect_to categories_path) : (render 'new')
  end

  def update
    category.update(category_params) ? (redirect_to categories_path) : (render 'edit')
  end

  def destroy
    category.destroy
    redirect_to categories_path
  end

  def category
    @category ||= Category.find(params[:id])
  end

  private
    def category_params
      params.require(:category).permit(:name, :enabled)
    end
end 
