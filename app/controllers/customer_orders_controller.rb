class CustomerOrdersController < ApplicationController
  def index
    @customer_orders = CustomerOrder.where(user_id: current_user.id)
  end

  def show
    customer_order
  end

  def cancel
    if customer_order.update_attributes({ canceled_at: Time.now })
      flash[:notice] = "You canceled order successful!"
      redirect_to(customer_orders_path)
    else 
      flash[:alert] = "You canceled order failure!"
      render('show')
    end
  end

  private
    def customer_order
      @customer_order ||= CustomerOrder.find(params[:id])
    end

    def customer_order_params
      params.require(:customer_order).permit(:user_id, :lunch_order_id, :product_id, :canceled_at)
    end
end 
