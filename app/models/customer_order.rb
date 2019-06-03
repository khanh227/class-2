class CustomerOrder < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :lunch_order

  validates :user_id, :menu_id, presence: true
end
