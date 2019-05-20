class CustomerOrdersController < ApplicationController
  def index
    @lunch_order = lunch_order
    @customer_orders = lunch_order.customer_orders.order(created_at: :desc)
  end

  def show
    customer_order
  end

  def new
    @customer_order = lunch_order.customer_orders.new
  end

  def edit
    customer_order
  end

  def create
    @customer_order = lunch_order.customer_orders.build(customer_order_params)
    if @customer_order.save 
      redirect_to lunch_order_customer_orders_path(lunch_order)
    else
      render('new')
    end
  end

  def update
    customer_order.update(customer_order_params) ? redirect_to(customer_orders_path) : render('edit')
  end

  def destroy
    customer_order.destroy
    redirect_to customer_orders_path
  end

  private
    def customer_order
      @customer_order ||= CustomerOrder.find(params[:id])
    end

    def lunch_order
      @lunch_order ||= LunchOrder.find(params[:lunch_order_id])
    end

    def customer_order_params
      params.require(:customer_order).permit(:user_id, :lunch_order_id, :product_id)
    end
end 
