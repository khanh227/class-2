class CustomerOrder < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :lunch_order
  has_many :customer_order_items
  accepts_nested_attributes_for :customer_order_items

  validates :user_id, :menu_id, presence: true
end
