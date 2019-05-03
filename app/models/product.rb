class Product < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, :description, :price, :quatity, presence: true

  scope :enabled, ->{ where(enabled: :true) }
end
