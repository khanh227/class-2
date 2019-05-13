class LunchOrdersController < ApplicationController
  def index
    @lunch_orders = LunchOrder.order(created_at: :desc)
  end

  def show
    lunch_order
  end

  def new
    @lunch_order = LunchOrder.new
  end

  def edit
    lunch_order
  end

  def create
    @lunch_order = LunchOrder.new(lunch_order_params)
    @lunch_order.save ? redirect_to(lunch_orders_path) : render('new')
  end

  def update
    lunch_order.update(lunch_order_params) ? redirect_to(lunch_orders_path) : render('edit')
  end

  def destroy
    lunch_order.destroy
    redirect_to lunch_orders_path
  end

  private
    def lunch_order
      @lunch_order ||= LunchOrder.find(params[:id])
    end

    def lunch_order_params
      params.require(:lunch_order).permit(:order_date)
    end
end
