class Product < ApplicationRecord
  belongs_to :user
  validates :name, :description, :price, :quatity, presence: true
end
