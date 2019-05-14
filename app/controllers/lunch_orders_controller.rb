class LunchOrdersController < ApplicationController
  def index
    @lunch_orders = LunchOrder.order(created_at: :desc)
  end

  def show
    @lunch_order ||= LunchOrder.find(params[:id])
  end
end
