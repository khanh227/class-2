class LunchOrdersController < ApplicationController
  def index
    @lunch_orders = LunchOrder.order(created_at: :desc)
  end

  def show
    lunch_order
  end

  private
    def lunch_order
      @lunch_order ||= LunchOrder.find(params[:id])
    end

    def lunch_order_params
      params.require(:lunch_order).permit(:order_date)
    end
end
