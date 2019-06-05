class CustomerOrdersController < ApplicationController
  load_and_authorize_resource

  def index; end

  def show; end

  def create
    @customer_order = CustomerOrdersService.new(customer_order_params)
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
      params.permit(:user_id, :menu_id, :canceled_at, :quatity)
    end

    def menu_params
      params.permit(:menu_name, :created_by, product_ids: [])
    end
end
