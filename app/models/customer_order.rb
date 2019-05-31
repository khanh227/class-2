class CustomerOrder < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :lunch_order

  validates :user_id, :product_id, presence: true
end
