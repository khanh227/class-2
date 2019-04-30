class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :edit]

  def index
    @products = Product.all.order(created_at: :desc)
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params.merge(user_id: current_user.id))
    redirect_to @product if @product.save
  end

  def update
    if @product.update(product_params)
      redirect_to product_path(@product)
    else
      render 'edit'
    end
  end

  def destroy
    redirect_to products_path if @product.destroy
  end

  private
    def product_params
      params.require(:product).permit(:name, :description, :price, :enabled, :quatity, :user_id)
    end

    def find_product
      @product ||= Product.find(params[:id])
    end
end
