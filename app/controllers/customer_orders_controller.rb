class CustomerOrdersController < ApplicationController
  before_action :authenticate_user!, only:[:new, :edit, :index]

  def index
    @customer_orders = CustomerOrder.where(user_id: current_user.id)
    @prices = total(@customer_orders)
  end

  def total(customer_orders)
    @total = 0

    @customer_orders.each do |order|
      @total += order.product.price
    end

    @total
  end

  def show
    customer_order
  end

  def destroy
    customer_order.destroy
    redirect_to customer_orders_path
  end

  private
    def customer_order
      @customer_order ||= CustomerOrder.find(params[:id])
    end

    def customer_order_params
      params.require(:customer_order).permit(:user_id, :lunch_order_id, :product_id)
    end
end 
