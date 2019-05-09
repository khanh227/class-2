class Product < ApplicationRecord
  acts_as_paranoid
  belongs_to :user, optional: true
  validates :name, :description, :price, :quatity, presence: true
  belongs_to :category
  scope :enabled, ->{ where(enabled: :true) }
end
