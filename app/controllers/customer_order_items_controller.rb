class CustomerOrderItemsController < ApplicationController
  private
    def customer_order_item_params
      params.require(:customer_order_item).permit(:customer_order_id, :product_id, :quatity)
    end
end