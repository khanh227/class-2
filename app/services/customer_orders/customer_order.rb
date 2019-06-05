class CustomerOrdersService
  attr_reader :customer_order

  def initialize(params:)
    @params = params
    @customer_order = CustomeOrder.new
  end

  def perform
    CustomerOrder.transaction do
      customer_order.save!
      save_customer_order_item!
      true
    end

    false
  end

  private

  def save_customer_order_item!
    order_items.each do |item|
      customer_order_item(item).save
    end
  end

  def customer_order
    CustomeOrder.new(
      user_id: @params[current_user.id]
      menu_id: @params[]
    )
  end

  def customer_order_item
    @customer_order = Customer
  end

  def order_items
    @order_item = @params[]
  end
end