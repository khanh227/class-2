class CustomerOrdersController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    @customer_order = CustomerOrder.new
    @customer_order.user_id = current_user.id
    @customer_order.lunch_order_id = LunchOrder.find_or_create_by(order_date: Date.today).id
    @customer_order.product_id = params[:selected_product]
    debugger
    if @customer_order.save
      Product.where(id: 'value').quatity -= 1
      redirect_to(customer_orders_path)
    end
  end

  def cancel
    if @customer_order.update_attribute(:canceled_at, Time.now)
      flash[:notice] = "You canceled order successful!"
      redirect_to(customer_orders_path)
    else 
      flash[:alert] = "You canceled order failure!"
      render('show')
    end
  end

  private

    def customer_order_params
      params.permit(:user_id, :lunch_order_id, :product_id, :canceled_at)
    end
end 
