class Product < ApplicationRecord
  belongs_to :user
  validates :name, :description, :price, :quatity, presence: true

  scope :enabled, ->{ where(enabled: :true) }
end
