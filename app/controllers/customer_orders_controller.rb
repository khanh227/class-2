class CustomerOrdersController < ApplicationController
  def index
    @customer_orders = CustomerOrder.where(user_id: current_user.id)
  end

  def show
    customer_order
  end

  private
    def customer_order
      @customer_order ||= CustomerOrder.find(params[:id])
    end

    def customer_order_params
      params.require(:customer_order).permit(:user_id, :lunch_order_id, :product_id)
    end
end 
