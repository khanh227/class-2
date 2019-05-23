class HomeController < ApplicationController
  def index
    @products = Product.enabled
  end

  def create
    @customer_order.product.name = @products
    
  end
end
