class CustomerOrder < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :lunch_order

  validates :user_id, uniqueness: { scope: :lunch_order_id }
  
  def update_attribute(name, value)
    send(name.to_s + '=', value)
    #save(false)
  end
end
