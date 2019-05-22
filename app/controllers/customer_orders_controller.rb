class CustomerOrdersController < ApplicationController
  def index
    @customer_orders = CustomerOrder.where(user_id: current_user.id)
  end

  def show
    customer_order
  end

  def cancel
    if customer_order.update_attribute(:canceled_at, Time.now)
      redirect_to(customer_orders_path)
      flash[:success] = 'You canceled order successful!'
    else 
      render('show')
      flash[:failure] = 'You canceled order failure!'
    end
  end

  private
    def customer_order
      @customer_order ||= CustomerOrder.find(params[:id])
    end

    def customer_order_params
      params.require(:customer_order).permit(:user_id, :lunch_order_id, :product_id, :canceled_at)
    end

    def success(message)
      self[:success] = message
    end

    def failure(message)
      self[:failure] = message
    end
end 
