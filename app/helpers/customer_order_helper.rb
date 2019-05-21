module CustomerOrderHelper
  def total(customer_orders)
    @total = 0
    @customer_orders.each do |order|
      @total += order.product.price
    end
    @total
  end
end
