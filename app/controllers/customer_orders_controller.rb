class CustomerOrdersController < ApplicationController
  def index
    @customer_orders = CustomerOrder.where(user_id: current_user.id)
  end

  def show
    customer_order
  end

  def cancel
    customer_order.user_id = nil
    customer_order.lunch_order_id = nil
    customer_order.product_id = nil
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
