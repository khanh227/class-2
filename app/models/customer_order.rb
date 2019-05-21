class CustomerOrder < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :lunch_order

  validates :user_id, uniqueness: { scope: :lunch_order_id }
end